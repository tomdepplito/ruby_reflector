require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/method_stats.rb'

describe Reflector::MethodStats do

  before :each do
    @stats = Reflector::MethodStats.new
  end

  it "initializes with a method name" do
    @stats.should be_an_instance_of Reflector::MethodStats
  end

  describe "#stats_results" do
    it "should print an empty hash when nothing's been added" do
      @stats.stats_results.inspect.should eq '{}'
    end
  end

  describe "#increment_method" do
    it "creates a new key in our hash if it's given a new method" do
      @stats.inc_method("length")
      @stats.stats_results.inspect.should eq "{:length=>1}"
    end

    it "increments an existing method" do
      @stats.inc_method("length")
      @stats.inc_method("length")
      @stats.stats_results[:length].should eq 2
    end

    it "can increment separate methods independently" do
      @stats.inc_method("length")
      @stats.inc_method("length")
      @stats.inc_method("==")
      @stats.stats_results.inspect.should eq "{:length=>2, :===>1}"
    end
  end
end