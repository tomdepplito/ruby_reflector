require 'spec_helper'

describe Reflector::ProjectStats do

  let(:stats) { Reflector::ProjectStats.new("newproject") }

  it "initializes correctly" do
    stats.should be_an_instance_of Reflector::ProjectStats
    stats.name.should eq "newproject"
  end

  it "prints an empty hash when nothing's been added" do
    stats.stats_results.inspect.should eq '{}'
  end

  it "takes an array of methods and converts them into a hash with unique counts" do
    stats.inc_stats([[:length, :length, :==, :include?]])
    stats.stats_results.inspect.should eq "{\"length\"=>2, \"==\"=>1, \"include?\"=>1}"
  end

  it "updates the values of the project when multiple files are sent to it" do
    stats.inc_stats([[:length, :length, :==, :include?],[:each, :length, :map, :==]])
    stats.stats_results.inspect.should eq "{\"length\"=>3, \"==\"=>2, \"include?\"=>1, \"each\"=>1, \"map\"=>1}"
  end

  it "saves its project stats"
end


