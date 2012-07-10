module Reflector
  class MethodStats

    def initialize
      @stats = {}
    end

    def inc_method(method)
      key = method.to_s.to_sym
      @stats.include?(key) ? @stats[key] += 1 : @stats[key] = 1
    end

    def stats_results
      @stats
    end
  end
end


