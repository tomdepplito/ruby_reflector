require '../lib/file_parser.rb'
require 'spec_helper.rb'
require 'test_file.rb'

include Reflector

describe Parser do

  describe '#method_array' do
    it 'should print out all method calls' do
      Parser.new('test_file.rb').method_array.should include :collect
    end

    it 'should find multiple instances of the same method call' do
      Parser.new('test_file.rb').method_array.should include :map, :map
    end

    it 'should only contain methods in the core library' do
      Parser.new('test_file.rb').method_array.should_not include :foobar
    end
  end

end