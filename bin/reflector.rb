#!/usr/bin/env ruby
require_relative '../init'

Dir.glob(File.join(ROOT_PATH, 'lib', '**', '*.rb')).each do |file|
  require file
end

@url = ARGV[0]

@repository = Reflector::RepoRetriever.new(@url)
@db = Reflector::Database.new('../db/reflector.db')


@files = Reflector::DirParser.new("../repos/" + @repository.repository_name).files # Gives us all our files

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
    :name => @repository.repository_name,
    :methods => project_stats.stats_results
})

# puts @db.method_stats_read(@repository.repository_name)

puts "Holy shit.  It might have worked.  Check the ../db/reflector.db"


@presentation = Reflector::Presentation.new(@db.methods_stats_read(@repository.repository_name), @repository.repository_name)
puts @presentation.console_print

@repository.delete_repository

