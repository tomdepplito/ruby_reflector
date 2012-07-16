require 'spec_helper'

include Reflector

describe DirParser do

  # How do we just fix this so it doesn't error out?  Same goes for the
  # project as a whole
  it "throws an error if you don't initialize with a filepath" do
    expect { fail_dir = DirParser.new }.should raise_error
  end

  before :all do
    @directory = DirParser.new(File.join(root_path, 'spec'))
  end

  it "initializes with a file path" do
    @directory.should be_an_instance_of DirParser
  end

  it "reads a directory into an array of its file names" do
    @directory.files.should include __FILE__
    @directory.files.should include File.join(File.dirname(__FILE__), "file_parser_spec.rb")
  end

  it "only includes filenames with .rb at the end" do
    File.open("testfile.txt", "w")
    @directory.files.should_not include "./testfile.txt"
    File.delete("testfile.txt")
  end

end
