require_relative '../init'
require 'sqlite3'

module Reflector
  class Repo
    def self.connection
      @connection ||= SQLite3::Database.new(ENV['database'])
    end

    def self.create(opts = {})
      sql = "INSERT INTO repos (name, url,clone_url,last_commit_date, created_at, updated_at) VALUES (?,?,?,?,?,?)"

      values = [
        opts.fetch(:name),
        opts.fetch(:url),
        opts.fetch(:clone_url),
        opts.fetch(:last_commit_date) { nil },
        Time.now.to_s,
        Time.now.to_s
      ]

      connection.execute(sql, values)
    end
  end
end
