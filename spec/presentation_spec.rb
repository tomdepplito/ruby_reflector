require 'spec_helper'

describe Reflector::Presentation do

  let(:project) { Reflector::Presentation.new([{"name"=>"length", "count"=>3},{"name"=>"map", "count"=>1}], "RnR") }

  context "initialize" do
    it "should initialize with method name and stats"  do
      project.should be_an_instance_of Reflector::Presentation
    end
  end

  context "console_print" do
    it "should print results to the console" do
      project.console_print.inspect.index("length").should_not be nil
    end
  end

end
