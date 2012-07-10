require 'nokogiri'
require 'open-uri'

module Reflector
  class Library
    attr_reader :library, :classes

    def initialize(url)
      @class_doc = Nokogiri::HTML(open(url))
      @library = make_library
      @classes = @library.collect {|key, value| key}
    end

    def make_library
      library_hash = {} #need to play around with inject more so this isn't necessary
      raw_methods.each do |line|
        method = line.split(' ')[0]
        class_name = line.split(' ')[1].gsub(/\(|\)/,'')
        !library_hash[class_name].nil? ? (library_hash[class_name] << method) : (library_hash[class_name] = [method])
      end
      library_hash
    end

    def methods_list
      raw_methods.collect { |position| position.split(" ")[0] }.uniq
    end

    def is_method?(method_name)
      methods_list.include?(method_name)
    end

    def is_class?(class_name)
      @classes.include?(class_name)
    end

    private
      def raw_methods
        @class_doc.css('div.entries a').collect{ |line| line.content.to_s if line.content.to_s.match(/\(.+\)/) }.compact!
      end
  end
end
