require 'sqlite3'

module Reflector
  class ProjectStats
    attr_reader :name

    def initialize(project_name)
      @name = project_name
      @project_stats = {}
    end

    def inc_stats(stats)
      @project_stats.merge!(stats) {|key, value1, value2| value1 + value2 }
    end

    def stats_results
      @project_stats
    end

  end
end