#!/usr/bin/ruby
#docopt?
require '../lib/dir_parser.rb'
require '../lib/repo_retrieve.rb'

@url = ARGV[0]
@repository = Reflector::RepoRetrieve.new(@url)

puts Reflector::DirParser.new("../repos/" + @repository.repository_name).files
@repository.delete_repository

