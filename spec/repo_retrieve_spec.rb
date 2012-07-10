require 'rspec'
require '../lib/repo_retrieve.rb'

describe Reflector::RepoRetrieve do

  it "will not initialize a new repo without a url" do
    expect { fail_retrieve = Reflector::RepoRetrieve.new }.should raise_error
  end

  before :all do
    @retrieve = Reflector::RepoRetrieve.new("https://github.com/Mayava/isHeAnAsshole")
  end

  it "initializes a new repo retrieve when passed a github url" do
    @retrieve.should be_an_instance_of Reflector::RepoRetrieve
  end

  it "locates the clone url based on the github url" do
    @retrieve.clone_url.should eq "git://github.com/Mayava/isHeAnAsshole.git"
  end

  it "locates the clone url based on the github url" do
    @retrieve.repository_name.should eq "isHeAnAsshole"
  end

  # How do I test creating a directory?
  # it "clones the repository into /repos" do
  #   Dir['../repos']
  # end

end