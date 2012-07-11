#!/usr/bin/ruby
#docopt?
require '../lib/dir_parser.rb'
require '../lib/repo_retrieve.rb'

@url = ARGV[0]
@library = Reflector::Library.new('http://ruby-doc.org/core-1.9.3/')
@repository = Reflector::RepoRetrieve.new(@url)
@files = Reflector::DirParser.new("../repos/" + @repository.repository_name).files # Gives us all our files

# parses each file
# does the lookup to the library
# instantiates a new method_stats class per file
@files.each { |file| Reflector::Parser.new(file) }

# @file_stats ||= Reflector::FileStats.new


# combine all the file stats to get the project stats
# write to the DB


# pull top 10 or whatever ruby git repos for comparison

@repository.delete_repository



