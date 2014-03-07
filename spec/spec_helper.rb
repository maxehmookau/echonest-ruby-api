require 'simplecov'
SimpleCov.start
require 'rubygems'
require 'bundler/setup'
require_relative '../lib/echonest-ruby-api/base.rb'
require 'echonest-ruby-api'
require 'vcr'
require 'webmock/rspec'
require 'coveralls'
#require 'mocha/api'

Coveralls.wear!

RSpec.configure do |config|
  config.mock_with :mocha
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  # TODO: Get rid of this when possible!
  c.allow_http_connections_when_no_cassette = true
end
