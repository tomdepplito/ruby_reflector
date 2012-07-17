require 'spec_helper'

describe Reflector::Repo do
  before :each do
    puts ENV['database']
    @test_db = Reflector::Repo.connection
    schema_path = File.expand_path(File.join(ROOT_PATH, 'db', 'schema.sql'))
    @test_db.execute_batch(File.read(schema_path))
  end

  after :each do
    File.delete(ENV['database'])
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
    end
  end
end
