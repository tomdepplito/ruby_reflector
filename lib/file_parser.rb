require 'ripper'
require 'ripper-plus'
require 'clean_ripper'

module Reflector
  class Parser
    def initialize(filename)
      file = File.read(filename)
      #@raw_results = Ripper.tokenize(file)
      @raw_results = Ripper::CleanSexpBuilder.new(file)
      @compiled_methods = []
    end


    def save_interpolation
      # @raw_results.each_with_index do |element, index|
      #         if element == '#{'
      #           @raw_results.delete_at(index)
      #           until element == '}' do
      #             @compiled_methods << element
      #             @raw_results.delete_at(index)
      #           end
      #         end
      #       end
      @list_of_elements = []
      is_interpolated = false
      @raw_results.each_with_index do |element, index|
        if element == '#{'
          is_interpolated = true
        elsif element == '}'
          is_interpolated = false
        end
        if is_interpolated
          @compiled_methods << element
        end
      end
      @compiled_methods
    end

    def find_string_locations
      # @raw_results.each_with_index do |element, index|
      #   if element == '"'
      #     @raw_results.delete_at(index)
      #     until element == '"' do
      #       @raw_results.delete_at(index)
      #     end
      #   end
      # end
      @string_locations = []
      is_quoted = false
      @raw_results.each_with_index do |element, index|
        if element =~ /"|'/
          is_quoted = true
        end
        puts is_quoted
        if is_quoted == true
          @string_locations << index
        end
        if element =~ /"|'/ && is_quoted == true
          is_quoted = false
        end
      end
      @string_locations
    end

    def delete_string_locations
      @string_locations.each do |index_no|
        @raw_results[index_no] = ""
      end
      @raw_results
    end

  #   def parse
  #     save_interpolation
  #     delete_strings
  #     @raw_results.select!{ |element| element != " " }
  #     @raw_results.each_with_index do |element, index|
  #       if element == "def" && @raw_results[index+1] == "self"
  #         4.times{|i| @raw_results.delete_at(index)}
  #       elsif element == "def"
  #         2.times{|i| @raw_results.delete_at(index)}
  #       end
  #     end
  #     @compiled_methods + @raw_results
  #   end
  # end

  def parse
    puts @raw_results.parse
  end
end
end

