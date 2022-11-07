# frozen_string_literal: true

ROOT = File.expand_path('..', __dir__)
$LOAD_PATH.unshift(File.join(ROOT, 'lib'), File.join(ROOT, 'spec'))

require 'simplecov'
SimpleCov.start do
  load_profile 'test_frameworks'
  enable_coverage :branch
end
require 'danger_plugin'
require 'support/helpers'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.filter_gems_from_backtrace 'bundler'
end
