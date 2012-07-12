require 'sqlite3'

module Reflector
  class ProjectStats
    attr_reader :name

    def initialize(project_name)
      @name = project_name
      @project_stats = {}
    end

    def inc_stats(stats)
      stats.compact.each do |file|
        file.compact.each do |method|
          @project_stats[method].nil? ? @project_stats[method] = 1 : @project_stats[method] += 1
        end
      end
    end

    def stats_results
      @project_stats
    end

  end
end