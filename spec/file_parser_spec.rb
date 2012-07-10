require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/file_parser.rb'

include Reflector

describe 'class Parser' do

  before :each do
    @somefile = File.stub(:readlines).and_return(["def self.aliases_for(attribute)", "attribute.to_s.sub(pattern, replace).to_sym"])
    @parser = Parser.new("somefile.rb")
    @newharderfile = File.stub(:readlines).and_return(["text << \#{new_entry(text)}***Created: \#{new_entry(text)}***Completed: \#{new_entry(text)} ", "def self.aliases_for(attribute)\nattribute.to_s.sub(pattern, replace).to_sym"])
    @parser2 = Parser.new("seomfile.rb")
    @thingsinquotes = File.stub(:readlines).and_return(["#to_s method should not be included here along with split", "def self.aliases_for(attribute)", "def self.aliases_for(attribute) #text"])
    @parsequotes = Parser.new("somefile.rb")


  end

  describe '#parse' do

    it 'should be able to parse the target method in this form: method(var)' do
     @parser.parse.should include 'sub'
    end

    it 'should not include any words that follow def' do
      @parser.parse.should_not include 'aliases_for'
    end

    it 'should still include methods found in string interpolation' do
      @parser2.parse.should include 'new_entry'
    end

    # it 'should not include method names that are included in quotes' do
    #   @parsequotes.parse.should_not include "to_s"
    #   @parsequotes.parse.should_not include "split"
    # end

    it 'should not include method names that are commented out' do

    end
  end

  describe '#remove_comments' do

    it 'should remove comments' do

    end
  end
end