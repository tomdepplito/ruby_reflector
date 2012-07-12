require 'sqlite3'

module Reflector
  class Database

    def initialize
      @db = SQLite3::Database.new( "../db/reflector.db" )
      @db.execute_batch( File.read('../db/schema.sql') )
      @db.close
    end

    def self.connection
        unless @connection
          @connection = SQLite3::Database.new("../db/reflector.db")
          @connection.results_as_hash = true
        end
        @connection
    end

    def repos_write(opts = {})

      sql = "INSERT INTO repos (name, url,clone_url,last_commit_date, created_at, updated_at) VALUES (?, ?,?,?,?,?)"
      Reflector::Database.connection.execute(sql, opts.fetch(:name), opts.fetch(:url), opts.fetch(:clone_url), opts.fetch(:last_commit_date), Time.now.to_s, Time.now.to_s)
    end

    def repos_get
      sql = "SELECT * FROM repos"
      Reflector::Database.connection.execute(sql)
    end

    def methods_write(method)
      sql = "INSERT INTO methods (name,created_at,updated_at) VALUES (?,?,?)"
      Reflector::Database.connection.execute(sql,method,Time.now.to_s, Time.now.to_s)
    end

  end
end