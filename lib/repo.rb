require_relative '../init'
require 'sqlite3'

module Reflector
  class Repo
    attr_accessor :name, :url, :clone_url, :last_commit_date, :created_at, :updated_at

    def initialize(opts={})
      self.name             = opts[:name]
      self.url              = opts[:url]
      self.clone_url        = opts[:clone_url]
      self.last_commit_date = opts[:last_commit_date]
      self.created_at       = opts[:created_at]
      self.updated_at       = opts[:updated_at]
    end

    def self.connection
      SQLite3::Database.new(ENV['database'])
    end

    def self.create(opts = {})
      sql = "INSERT INTO repos (name, url,clone_url,last_commit_date, created_at, updated_at) VALUES (?,?,?,?,?,?)"
      now = Time.now.to_s
      values = [
        opts.fetch(:name),
        opts.fetch(:url),
        opts.fetch(:clone_url),
        opts.fetch(:last_commit_date) { nil },
        now,
        now
      ]

      connection.execute(sql, values)
      self.new(opts.merge(:created_at => now, :updated_at => now))
    end
  end
end
