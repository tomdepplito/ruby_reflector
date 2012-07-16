require 'spec_helper'

describe Reflector::Database do

  let(:database_path) { File.join(ROOT_PATH, 'db', 'test.db') }
  let(:db) { SQLite3::Database.new(database_path) }
  let!(:database) { Reflector::Database.new(database_path) }

  after :all do
    File.delete(database_path)
  end

  it "the database exists" do
    File.exists?(database_path).should be_true
  end

  it "writes the methods library to the db" do
    db.execute("SELECT * FROM methods").length.should eq 850
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
    database.methods_stats_read("RR_RnR").length.should eq 10
  end

end
