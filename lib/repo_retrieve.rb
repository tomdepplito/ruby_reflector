require 'nokogiri'
require 'open-uri'

module Reflector
  class RepoRetrieve
    attr_reader :clone_url, :repository_name

    def initialize(repo_url)
      @github_doc      = Nokogiri::HTML(open(repo_url))
      @clone_url       = @github_doc.css('li.public_clone_url a').map { |line| line['href'] }[0] #need to get a better way than map
      @repository_name = @github_doc.css('a.js-current-repository').map { |line| line.content }[0]
      clone_repository
    end

    def clone_repository
      system "git clone #@clone_url ../repos/#@repository_name"
    end

    def delete_repository
      system "rm -rf ../repos/#@repository_name"
    end
  end
end
