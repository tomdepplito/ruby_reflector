require 'fakeweb'
require 'simplecov'
SimpleCov.start

def root_path
  File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

Dir.glob(File.join(root_path, 'lib', '**', '*.rb')).each do |file|
  require file
end

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:get, 'https://github.com/Devbootcamp/RR_RnR', :body => File.read(File.join(root_path, 'spec', 'fixtures', 'github.html')))
FakeWeb.register_uri(:get, 'http://ruby-doc.org/core-1.9.3/', :body => File.read(File.join(root_path, 'spec', 'fixtures', 'rubydoc.html')))
RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
