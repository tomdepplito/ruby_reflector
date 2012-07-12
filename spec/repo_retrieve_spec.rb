require 'simplecov'
SimpleCov.start
require 'rspec'
require '../lib/repo_retrieve.rb'
require 'spec_helper.rb'

describe Reflector::RepoRetrieve do

  it "will not initialize a new repo without a url" do
    expect { fail_retrieve = Reflector::RepoRetrieve.new }.should raise_error
  end

  before :all do
    @retrieve = Reflector::RepoRetrieve.new("https://github.com/Devbootcamp/RR_RnR")
  end

  it "initializes a new repo retrieve when passed a github url" do
    @retrieve.should be_an_instance_of Reflector::RepoRetrieve
  end

  it "locates the clone url based on the github url" do
    @retrieve.clone_url.should eq "git://github.com/Devbootcamp/RR_RnR.git"
  end

  it "locates the clone url based on the github url" do
    @retrieve.repository_name.should eq "RR_RnR"
  end

  it "clones the repository into /repos" do
    Dir.entries("../repos").length.should eq 3 #directories have . and .. by default
    Dir.entries("../repos")[2].should eq "RR_RnR"
  end

  # This is currently tied to the above test.  We should really de-couple this.
  it "deletes the repository from /repos" do
    @retrieve.delete_repository
    Dir.entries("../repos").length.should eq 2 #directories have . and .. by default
  end

  #What do we do when we get an invalid github URL?
  #Most recent commit from repo?

end