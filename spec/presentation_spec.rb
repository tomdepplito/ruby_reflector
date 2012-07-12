require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/presentation.rb'

include Reflector

describe Presentation do

  let(:project) { Presentation.new([{"name"=>"length", "count"=>3},{"name"=>"map", "count"=>1}], "RnR") }

  context "initialize" do
    it "should initialize with method name and stats"  do
      project.should be_an_instance_of Presentation
    end
  end

  context "console_print" do
    it "should print results to the console" do
      # STDOUT.should_receive(:puts).with("****************************
      #                                   Repo Name, Top 20 Methods
      #                                   ****************************
      #                                   =======================
      #                                   Rank  | Method | Count
      #                                   =======================")
      # STDOUT.should_receive(:puts).with("1.    | length   | 3")
      # STDOUT.should_receive(:puts).with("2.    | map   | 1")
      # # project.console_print
      # test = Presentation.new([{"name"=>"length", "count"=>3},{"name"=>"map", "count"=>1}], "RnR")
      # test.console_print
      # output << -BEGIN
      #   "****************************
      #   RnR, Top 20 Methods
      #   ****************************
      #   =======================
      #   Rank  | Method | Count
      #   =======================
      #   1.    | length | 50
      #   2.    | each   | 20
      #   ======================="
      # END
      project.console_print.inspect.index("length").should_not be nil
    end
  end

end
