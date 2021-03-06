require_relative '../init'

module Reflector
  class Database

    def initialize(file_path)
      @@file_path = file_path
      db = SQLite3::Database.new(file_path)
      schema_path = File.expand_path(File.join(ROOT_PATH, 'db', 'schema.sql'))
      db.execute_batch(File.read(schema_path))
      unless methods_read.count > 849
        methods_write
      end
      db.close
    end

    def self.connection
      @connection ||= SQLite3::Database.new(@@file_path)
      @connection.results_as_hash = true
      @connection
    end

    def repos_write(opts = {})
      sql = "INSERT INTO repos (name, url,clone_url,last_commit_date, created_at, updated_at) VALUES (?, ?,?,?,?,?)"
      Reflector::Database.connection.execute(sql, opts.fetch(:name), opts.fetch(:url), opts.fetch(:clone_url), opts.fetch(:last_commit_date), Time.now.to_s, Time.now.to_s)
      #Not sure about the :name fetch here
      methods_stats_write(opts.fetch(:methods), opts.fetch(:name))
    end

    def methods_write
      lib ||= Reflector::Library.new('http://ruby-doc.org/core-1.9.3/')
      lib.methods_list.each do |method|
        sql = "INSERT INTO methods (name,created_at,updated_at) VALUES (?,?,?)"
        Reflector::Database.connection.execute(sql,method,Time.now.to_s, Time.now.to_s)
      end
    end

    def methods_read
      sql = "SELECT name FROM methods"
      Reflector::Database.connection.execute(sql)
    end

    #This can use some serious optimizing later
    def methods_stats_write(methods, name)
      sql = "INSERT INTO methods_stats (repo_id, method_id, count, created_at, updated_at) VALUES (?, ?, ?, ?, ?);"
      rep_id = repo_id(name)
      methods.each do |key, value|
        if !key.nil? && !value.nil? #cleanup needed
          Reflector::Database.connection.execute(sql, rep_id, method_id(key), value, Time.now.to_s, Time.now.to_s)
        end
      end
    end

    def methods_stats_read(repo_name)
      # Need to fix the fact that we get extra data besides name, count {"name"=>"length", "count"=>3, 0=>"length", 1=>3}
      # Need to test the descending order
      sql = "SELECT methods.name, methods_stats.count FROM methods, methods_stats WHERE methods.id = methods_stats.method_id AND methods_stats.repo_id = (?) ORDER BY methods_stats.count DESC"
      repo_id = repo_id(repo_name)
      Reflector::Database.connection.execute(sql, repo_id)
    end

    private

    #Need to debug why we're getting nil method names here
    def method_id(name)
      sql = "SELECT id FROM methods WHERE name = (?)"
      Reflector::Database.connection.execute(sql, name.to_s)[0]["id"]
    end

    def repo_id(name)
      sql = "SELECT id FROM repos WHERE name = (?)"
      Reflector::Database.connection.execute(sql, name)[0]["id"]
    end

    def method_name(id)
      sql = "SELECT name FROM methods WHERE id = (?)"
      Reflector::Database.connection.execute(sql, id)[0]["name"]
    end

    def repo_name(id)
      sql = "SELECT name FROM repos WHERE id = (?)"
      Reflector::Database.connection.execute(sql, id)[0]["name"]
    end


  end
end
