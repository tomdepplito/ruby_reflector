
module  Reflector

  class Presentation

    def initialize(stats, repo_name)
      @stats = stats
      @repo_name = repo_name
    end

    def console_print
      report = []
      report << "********************************************************
#{@repo_name}, Top 20 Methods
********************************************************
========================================================
Rank\t|\tMethod\t\t\t|\tCount
========================================================"
      @stats.each_with_index { |stat, index| report << "#{index + 1}.\t|\t#{stat['name']}\t\t\t|\t#{stat['count']}" }

      report
    end
  end
end

