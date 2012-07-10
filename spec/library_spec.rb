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

  it "selects all of the methods from ruby doc" do
    @class_doc.raw_methods.length.should be > 1700
  end

  it "returns a library hash with class keys and arrays of their respective methods" do
    @class_doc.library["SystemCallError"].should eq ["===", "new", "errno"]
    @class_doc.library["SignalException"].should eq ["new", "signo"]
  end

  it "returns just the classes from the library" do
    @class_doc.classes.length.should eq 68
  end
end


