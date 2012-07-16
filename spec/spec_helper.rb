require 'simplecov'
SimpleCov.start

def root_path
  File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

Dir.glob(File.join(root_path, 'lib', '**', '*.rb')).each do |file|
  require file
end

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
