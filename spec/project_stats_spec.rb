require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/project_stats.rb'

include Reflector

describe ProjectStats do

  # before :all do
  #   @db_filepath = './test.db'
  #   @db = SQLite3::Database.new(@db_filepath)
  #   @db.execute("CREATE TABLE project_stats (
  #       id INTEGER PRIMARY KEY AUTOINCREMENT,
  #       created_at TEXT NULL,
  #       updated_at TEXT NULL,
  #       );")
  # end

  # after :all do
  #   File.delete('./test.db')
  # end

  # it 'adds tasks to the list' do
  #   @db.execute("SELECT description FROM tasks WHERE id=1;")[0][0].should eq "add this task"
  # end

  before :each do
    @project = ProjectStats.new("newproject")
  end

  it "initializes correctly" do
    @project.should be_an_instance_of ProjectStats
    @project.name.should eq "newproject"
  end

  it "prints an empty hash when nothing's been added" do
    @project.stats_results.inspect.should eq '{}'
  end

  it "takes another hash" do
    @project.inc_stats({:length => 1, :== => 2})
    @project.stats_results.inspect.should eq '{:length=>1, :===>2}'
  end

  it "updates the values of the project hash, not overwrite it" do
    @project.inc_stats({:length => 1, :== => 2})
    @project.inc_stats({:length => 1, :== => 2})
    @project.stats_results.inspect.should eq '{:length=>2, :===>4}'
  end

  it "saves its project stats to the database" do
    @project.inc_stats({:length => 1, :== => 2})
    @project.inc_stats({:length => 1, :== => 2})
    @project.save
    doc.execute("SELECT * FROM project_stats").should eq "whatever"
  end
end