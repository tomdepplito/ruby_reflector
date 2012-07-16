require 'spec_helper'

describe Reflector::RepoRetriever do

  let(:repos_path) { File.join(ROOT_PATH, 'repos') }

  before :all do
    @retriever = Reflector::RepoRetriever.new("https://github.com/Devbootcamp/RR_RnR")
  end

  after :all do
    @retriever.delete_repository
  end

  it "will not initialize a new repo without a url" do
    expect { fail_retrieve = Reflector::RepoRetriever.new }.should raise_error
  end

  it "initializes a new repo retrieve when passed a github url" do
    @retriever.should be_an_instance_of Reflector::RepoRetriever
  end

  it "locates the clone url based on the github url" do
    @retriever.clone_url.should eq "git://github.com/Devbootcamp/RR_RnR.git"
  end

  it "locates the clone url based on the github url" do
    @retriever.repository_name.should eq "RR_RnR"
  end

  it "clones the repository into /repos" do
    Dir.entries(repos_path).include?(@retriever.repository_name).should be true
  end

  it "creates a directory parser object after cloning a repository" do
    @retriever.should
  end

  # This is currently tied to the above test.  We should really de-couple this.
  it "deletes the repository from /repos" do
    @retriever.delete_repository
    Dir.entries(repos_path).include?(@retriever.repository_name).should_not be true
  end

  #What do we do when we get an invalid github URL?
  #Most recent commit from repo?

end
