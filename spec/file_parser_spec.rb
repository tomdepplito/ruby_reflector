require 'spec_helper'

include Reflector

describe Parser do
  before :each do
    @file_path = File.join(File.dirname(__FILE__), 'test_file.rb')
  end

  describe '#method_array' do
    it 'should print out all method calls' do
      Parser.new(@file_path).method_array.should include :collect
    end

    it 'should find multiple instances of the same method call' do
      Parser.new(@file_path).method_array.should include :map, :map
    end

    it 'should only contain methods in the core library' do
      Parser.new(@file_path).method_array.should_not include :foobar
    end
  end

end
