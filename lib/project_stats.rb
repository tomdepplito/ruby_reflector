require_relative '../init'

module Reflector
  class ProjectStats
    attr_reader :name

    def initialize(project_name)
      @name = project_name
      @project_stats = {}
      # @library = Reflector::Library.new('http://ruby-doc.org/core-1.9.3/')
    end

    def inc_stats(stats)
      stats.compact.each do |file|
        file.compact.each do |method|
          @project_stats[method.to_s].nil? ? @project_stats[method.to_s] = 1 : @project_stats[method.to_s] += 1
        end
      end
    end

    def stats_results
      @project_stats
    end

  end
end
