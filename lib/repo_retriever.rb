require 'nokogiri'
require 'open-uri'

module Reflector
  class RepoRetriever
    attr_reader :clone_url, :repository_name

    def initialize(repo_url)
      #@repository.delete_repository if exists    do it here
      @github_doc      = Nokogiri::HTML(open(repo_url))
      @clone_url       = @github_doc.css('li.public_clone_url a').map { |line| line['href'] }[0] #need to get a better way than map
      @repository_name = @github_doc.css('a.js-current-repository').map { |line| line.content }[0]
      clone_repository
    end

    def clone_repository
      system "git clone #@clone_url #{repo_path}/#@repository_name"
    end

    def delete_repository
      system "rm -rf #{repo_path}/#@repository_name"
    end

    def repo_path
      File.expand_path(File.join(ROOT_PATH, 'repos'))
    end
  end
end
