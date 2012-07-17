require 'spec_helper'

describe Reflector::Repo do
  before :each do
    @test_db = Reflector::Repo.connection
    schema_path = File.expand_path(File.join(ROOT_PATH, 'db', 'schema.sql'))
    @test_db.execute_batch(File.read(schema_path))
  end

  after :each do
    File.delete(ENV['database']) if File.exist?(ENV['database'])
  end

  describe '.create' do
    context 'given a hash of attributes' do
      it 'creates a database record' do
        Reflector::Repo.create(:url => 'blah',
                               :clone_url => 'whatevs',
                               :name => 'who cares?')

        results = @test_db.execute <<-SQL
          SELECT url, clone_url, name FROM repos
        SQL

        results.should == [[ 'blah', 'whatevs', 'who cares?' ]]
      end

      it 'returns an instance of repo' do
        repo = Reflector::Repo.create(:url => 'blah',
                                      :clone_url => 'whatevs',
                                      :name => 'who cares?')
        repo.should be_an_instance_of Reflector::Repo
      end
    end
  end

  describe '#name' do
    it 'returns the name of the repo' do
      repo = Reflector::Repo.create(:url => 'blah',
                                    :clone_url => 'whatevs',
                                    :name => 'who cares?')
      repo.name.should == 'who cares?'
    end
  end
end
