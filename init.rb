require 'sqlite3'
require 'find'
require 'ripper'
require 'clean_ripper'
require 'nokogiri'
require 'open-uri'

ROOT_PATH = File.expand_path(File.dirname(__FILE__))

ENV['database'] ||= File.join(ROOT_PATH, 'db', 'reflector.db')
