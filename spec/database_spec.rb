require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/database.rb'
require '../lib/library.rb'

include Reflector

describe Database do
    let( :database ) { Reflector::Database.new("../db/reflector_test.db") }
    let( :db ) { SQLite3::Database.new("../db/reflector_test.db") }

    before :all do
      lib ||= Reflector::Library.new('http://ruby-doc.org/core-1.9.3/')
      lib.methods_list.each { |method| database.methods_write(method) }
    end

    after :all do
      File.delete('../db/reflector_test.db')
    end

    it "the database exists" do
      database
      File.exists?( "../db/reflector_test.db" ).should be_true
    end

    it "has 3 tables and the sqlite sequence table" do
      db.execute("SELECT name FROM sqlite_master WHERE type = 'table'").length.should eq 4
    end

    it "writes a project to the repos table" do
      database.repos_write({
          :url => "https://github.com/Devbootcamp/RR_RnR",
          :clone_url => "https://github.com/Devbootcamp/RR_RnR.git",
          :last_commit_date => "NULL",
          :name => "RR_RnR",
          :methods => { :length => 3, :== => 2, :include? => 1, :each => 1, :map => 1 }
      })
      db.execute("SELECT * FROM repos").first[0].should eq 1
      db.execute("SELECT * FROM repos").first[1].should eq "RR_RnR"
      db.execute("SELECT * FROM repos").first[2].should eq "https://github.com/Devbootcamp/RR_RnR"
      db.execute("SELECT * FROM repos").first[3].should eq "https://github.com/Devbootcamp/RR_RnR.git"
      db.execute("SELECT * FROM repos").first[4].should eq "NULL"
    end

    it "return result set from the repos table" do
      repos_rows = db.execute ("SELECT COUNT(*) FROM repos")
      rs = database.repos_get
      rs.count.should eq repos_rows[0][0]
    end

    it "writes the methods library to the db" do
      db.execute("SELECT * FROM methods").length.should eq 850
    end

    it "writes the repo and its methods to the db" do
      database.repos_write({
          :url => "https://github.com/Devbootcamp/RR_RnR",
          :clone_url => "https://github.com/Devbootcamp/RR_RnR.git",
          :last_commit_date => "NULL",
          :name => "RR_RnR",
          :methods => { :length => 3, :== => 2, :include? => 1, :each => 1, :map => 1 }
      })
      db.execute("SELECT methods_stats.count FROM methods_stats INNER JOIN methods ON methods.id = methods_stats.method_id WHERE methods.name like 'length'")[0][0].should eq 3
    end

    it "reads the methods from the db based on a repo name" do
      puts database.methods_stats_read("RR_RnR")
      puts database.methods_stats_read("RR_RnR").class
      puts puts database.methods_stats_read("RR_RnR")[0].class
      database.methods_stats_read("RR_RnR").length.should eq 10
    end
end


