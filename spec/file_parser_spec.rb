require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/file_parser.rb'

include Reflector


describe 'class Parser' do

  before :each do
    #@somefile = File.stub(:read).and_return('def self.aliases_for(attribute)\n attribute.to_s.sub(pattern, replace).to_sym')
    @parser = Parser.new("../test.rb")
    #@newharderfile = File.stub(:read).and_return("def self.fib(n)\n  return 0 if n == 0\n  return 1 if n == 1\n  return fib!(n-1) + fib(n-2) #akdsjfhaksdjfhaskdjjdfhsds\n \#{thisshould}")
    @parser2 = Parser.new("../test.rb")
    #@thingsinquotes = File.stub(:read).and_return('#to_s method should not be included here along with split def self.aliases_for(attribute) def self.aliases_for(attribute) #text')
    @parsequotes = Parser.new("../test.rb")
    @short_text = File.stub(:read).and_return("\'to_s\'\'fcy'\\'urtcv\'")
    @parser3 = Parser.new("test")


  end

  # describe '#save_interpolation' do
  #    it 'should not include string interpolation braces' do
  #      @parser2.save_interpolation.should_not include "\#{"
  #      @parser2.save_interpolation.should_not include "}"
  #    end
  #
  #    it 'should include non-character word inside of braces' do
  #      @parser2.save_interpolation.should include "thisshould"
  #    end
  #  end
  #
  #  describe '#find_string_locations' do
  #    it 'should return an array of locations for quotes' do
  #      @parser3.find_string_locations.should eq [0,2,5,7]
  #    end
  #  end

  describe '#parse' do

    # it 'should be able to parse the target method in this form: method(var)' do
    #      @parser.parse.should include 'sub'
    #     end
    #
    #     it 'should not include any words that follow def' do
    #       @parser.parse.should_not include 'aliases_for'
    #     end
    #
    #     it 'should still include methods found in string interpolation' do
    #       @parser2.parse.should include 'new_entry'
    #     end

    # it 'should not include method names that are included in quotes' do
    #   @parsequotes.parse.should_not include "to_s"
    #   @parsequotes.parse.should_not include "split"
    # end

    it 'should print out all method calls' do
      code = File.stub(:read).and_return("@raw_results.each_with_index {|element, index| puts element}")
      parser4 = Parser.new("test")
      parser4.parse
    end

    it 'should not include method names that are commented out' do

    end
  end

  describe '#remove_comments' do

    it 'should remove comments' do

    end
  end
end