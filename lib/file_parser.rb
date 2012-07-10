module Reflector
  class Parser
    def initialize(filename)
      @file = File.readlines(filename)
    end

    def line_parse
      @file.each do |line|
        line.parse
      end
    end

    def remove_comments
      @file.each do |line|
        if line.include?('#') && line.include?('\"')
          if line.count('"', "#")  > 0
            line.slice()
      end
    end

    def parse
      full_results = []
      @file.each do |line|
        split_results = line.gsub(/\W/, " ").split
        full_results << split_results.each_with_index do |word, index|
          if word == 'def' && split_results[index+1] == 'self'
            3.times{|i| split_results.delete_at(index)}
          elsif word == 'def'
            2.times{|i| split_results.delete_at(index)}
          end
        end
      end
      full_results.flatten
    end
  end
end