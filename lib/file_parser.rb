require 'ripper'
require 'clean_ripper'
# require './library.rb'

module Reflector
  class Parser

    def initialize(source)
      @source = File.read(source)
      @sexp   = Ripper::CleanSexpBuilder.parse(@source)
      @method_array = []
      build_counts!(@sexp)
    end

    def method_array
      array = []
      library_object = Library.new('http://ruby-doc.org/core-1.9.3/')
      @method_array.each do |method|
        if library_object.is_method?(method.to_s)
          array << method
        end
      end
      array
    end

    private

    def build_counts!(sexp)
      parse(sexp)
      # Don't call build_counts! for atoms
      sexp.each do |s|
        build_counts!(s) if s.is_a?(Array)
      end
    end

    def parse(sexp)
      case sexp.first
      when :call
        @method_array << sexp[2]
      end
    end

  end
end
