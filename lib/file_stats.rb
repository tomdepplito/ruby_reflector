module Reflector
  class FileStats

    def initialize
      @file_stats = {}
    end

    def inc_method(method)
      key = method.to_s.to_sym
      @file_stats.include?(key) ? @file_stats[key] += 1 : @file_stats[key] = 1
    end

    def stats_results
      @file_stats
    end
  end
end


