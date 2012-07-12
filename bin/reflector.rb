#!/usr/bin/ruby
#docopt?
require '../lib/dir_parser.rb'
require '../lib/repo_retrieve.rb'
require '../lib/library.rb'
require '../lib/file_parser.rb'
require '../lib/project_stats.rb'
require '../lib/database.rb'



@url = ARGV[0]
@library = Reflector::Library.new('http://ruby-doc.org/core-1.9.3/')
@repository = Reflector::RepoRetrieve.new(@url)
@files = Reflector::DirParser.new("../repos/" + @repository.repository_name).files # Gives us all our files
puts "Creating our local database"
@db = Reflector::Database.new('../db/reflector.db')

# write the library to the DB FIRST!!!!!!
puts "Creating our ruby library"
@library.methods_list.each { |method| @db.methods_write(method) }

# parses each file
# does the lookup to the library
# instantiates a new method_stats class per file
methods = @files.collect { |file|  puts file; Reflector::Parser.new(file).method_array }

project_stats = Reflector::ProjectStats.new(@repository.repository_name) #needs to be created: url and commit_date

# @repository.repository_name,
# "something",
# @repository.clone_url,
# "something"
project_stats.inc_stats(methods)
# puts project_stats.stats_results
# projects_stats.stats_results = {:methods => {:length => 1, :== => 2, :some_other_method => 5}, :name => "name", :url => "url", :clone_url => "clone url", :commit_date => "some date here"}

puts project_stats.stats_results.inspect

@db.repos_write({
    :url => "https://github.com/Devbootcamp/RR_RnR",
    :clone_url => @repository.clone_url,
    :last_commit_date => "NULL",
    :name => "RR_RnR",
    :methods => project_stats.stats_results
})
#
puts "Holy shit.  It might have worked.  Check the ../db/reflector.db"
#
# # db.save(project_stats.stats_results)
# #
# # @presentation = Reflector::Presentation.new(from_db_somehow)
# # presentation.show
# # # pull top 10 or whatever ruby git repos for comparison
#
@repository.delete_repository
