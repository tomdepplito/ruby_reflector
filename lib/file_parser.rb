require 'ripper'
require 'clean_ripper'
# require './library.rb'

module Reflector
  class Parser
    attr_reader :method_array

    def initialize(source)
      @source = File.read(source)
      @sexp   = Ripper::CleanSexpBuilder.parse(@source)
      @method_array = []
      build_counts!(@sexp)
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
