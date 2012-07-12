require 'sqlite3'
# require 'library.rb'

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
          #Last minute check to see if we're dealing with core library, only
          # if @library.is_method?(method)
            @project_stats[method].nil? ? @project_stats[method] = 1 : @project_stats[method] += 1
          # end
        end
      end
    end

    def stats_results
      @project_stats
    end

  end
end