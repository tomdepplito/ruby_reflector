require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/file_parser.rb'
require 'spec_helper.rb'
require 'test_file.rb'

include Reflector


describe Parser do

  context '#method_array' do
    it 'contains non-object methods' do
      Parser.new('test_file.rb').method_array.should include :foobar
    end

    it 'should print out all method calls' do
      Parser.new('test_file.rb').method_array.should include :collect
    end

    it 'should find multiple instances of the same method call' do
      Parser.new('test_file.rb').method_array.should include :map, :map
    end
  end
end