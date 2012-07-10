require 'find'

module Reflector
  class DirParser
    attr_reader :files
    
    def initialize(directory_path)
      @files = Find.find(directory_path).collect { |file| file if file.match(/\.rb\Z/)}
    end
  end
end