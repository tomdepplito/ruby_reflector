require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/library.rb'

describe Reflector::Library do

  it "will not initialize without the target library" do
    expect { doc = Reflector::Library.new }.should raise_error
  end

  before :all do
    @class_doc = Reflector::Library.new('http://ruby-doc.org/core-1.9.3/')
  end

  it "initializes a new library" do
    @class_doc.should be_an_instance_of Reflector::Library
  end

  it "returns a library hash with class keys and arrays of their respective methods" do
    @class_doc.library["SystemCallError"].should eq ["===", "new", "errno"]
    @class_doc.library["SignalException"].should eq ["new", "signo"]
  end

  it "returns just the classes from the library" do
    @class_doc.classes.length.should eq 68
  end

  it "returns methods from the library" do
    @class_doc.methods_list.should include "length"
    @class_doc.methods_list.should include "collect!"
  end

  it "does not duplicate method names in the array" do
    @class_doc.methods_list.count {|index| index == "length" }.should eq 1
  end

  it "confirms a method is in the library" do
    @class_doc.is_method?("==").should be true
    @class_doc.is_method?("this isn't a method").should be false
  end

  it "confirms a method is in the library" do
    @class_doc.is_class?("String").should be true
    @class_doc.is_class?("this isn't a class").should be false
  end
end


