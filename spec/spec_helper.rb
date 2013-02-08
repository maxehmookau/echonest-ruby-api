require 'rubygems'
require 'bundler/setup'

require 'echonest-ruby-api'

RSpec.configure do |config|
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation 
end