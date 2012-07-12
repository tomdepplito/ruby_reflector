#!/usr/bin/ruby
#docopt?
require '../lib/dir_parser.rb'
require '../lib/repo_retrieve.rb'
require '../lib/file_parser.rb'
require '../lib/project_stats.rb'
require '../lib/database.rb'
require '../lib/library.rb'
require '../lib/presentation.rb'

####################
#This is just here for testing
####################

# system 'rm -rf ../repos/*.*'



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

puts "Constructing repo stats"
project_stats = Reflector::ProjectStats.new(@repository.repository_name) #needs to be created: url and commit_date

project_stats.inc_stats(methods)

puts project_stats.stats_results

@db.repos_write({
    :url => "https://github.com/Devbootcamp/RR_RnR",
    :clone_url => @repository.clone_url,
    :last_commit_date => "NULL",
    :name => "RR_RnR",
    :methods => project_stats.stats_results
})

# presentation = Reflector::Presentation.new(@db.read_repo(@repository.repository_name))
# presentation.console_print

#
puts "Holy shit.  It might have worked.  Check the ../db/reflector.db"


@presentation = Reflector::Presentation.new(@db.method_stats_read(@repository.repository_name))
puts @presentation.console_print


