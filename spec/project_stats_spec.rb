require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/project_stats.rb'

include Reflector

describe ProjectStats do

  let(:project) { ProjectStats.new("newproject") }

  it "initializes correctly" do
    project.should be_an_instance_of ProjectStats
    project.name.should eq "newproject"
  end

  it "prints an empty hash when nothing's been added" do
    project.stats_results.inspect.should eq '{}'
  end

  it "takes another hash" do
    project.inc_stats({:length => 1, :== => 2})
    project.stats_results.inspect.should eq '{:length=>1, :===>2}'
  end

  it "updates the values of the project hash, not overwrite it" do
    project.inc_stats({:length => 1, :== => 2})
    project.inc_stats({:length => 1, :== => 2})
    project.stats_results.inspect.should eq '{:length=>2, :===>4}'
  end

  it "saves its project stats"
end