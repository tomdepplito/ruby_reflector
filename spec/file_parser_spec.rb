require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/file_parser.rb'

include Reflector


describe Parser do
  context '#new' do
    it "accepts a string as a parameter" do
      expect {
        Parser.new('')
      }.should_not raise_error
    end

    it "accepts an IO object as a parameter" do
      expect {
        io = mock
        io.stub!(:read).and_return('')
        Parser.new(io)
      }.should_not raise_error
    end
  end

  context '#method_array' do
    it 'contains non-object methods' do
      Parser.new('foobar(5)').method_array.should eq [:foobar]
    end

    it 'should print out all method calls' do
      Parser.new('[1,2,3].map').method_array.should eq [:map]
    end

    it 'should find multiple instances of the same method call' do
      Parser.new('[1,2,3].map;[1,2,3].map').method_array.should eq [:map, :map]
    end
  end
end