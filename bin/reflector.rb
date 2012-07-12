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
methods = @files.collect { |file| Reflector::Parser.new(file).method_array }

# @file_stats ||= Reflector::FileStats.new
projects stats --> {:name, :url, :clone_url, :commit_date, :methods => []}

Reflector::ProjectStats.new(methods,
                            @repository.name,
                            @repository.url, #needs to be created
                            @repository.clone_url,
                            @repository.commit_date) #needs to be created

# combine all the file stats to get the project stats
# write to the DB


# pull top 10 or whatever ruby git repos for comparison

@repository.delete_repository
