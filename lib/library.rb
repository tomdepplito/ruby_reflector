require 'nokogiri'
require 'open-uri'

module Reflector
  class Library
    attr_reader :raw_methods, :library, :classes

    def initialize(url)
      @class_doc = Nokogiri::HTML(open(url))
      @library = make_library
      @classes = @library.collect {|key, value| key}
    end

    def make_library
      library_hash = {} #should probably rename this to library
      @raw_methods = @class_doc.css('div.entries a').collect{ |line| line.content.to_s } #this can be updated with John's new query
      @raw_methods.each do |line|
        unless line.split(' ')[1].nil? #this can go once we updated @raw_methods to ignore the nils
          method = line.split(' ')[0]
          class_name = line.split(' ')[1].gsub(/\(|\)/,'')
          !library_hash[class_name].nil? ? (library_hash[class_name] << method) : (library_hash[class_name] = [method])
        end
      end
      library_hash
    end
  end
end
