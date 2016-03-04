require 'echonest-ruby-api/config'
require "echonest-ruby-api/version"
require 'echonest-ruby-api/artist'
require 'echonest-ruby-api/song'
require 'echonest-ruby-api/error'
require 'echonest-ruby-api/playlist'
require 'echonest-ruby-api/genre'

module Echonest

  class ConfigError < StandardError
    ERROR_TEXT = <<-eos
    You must setup Echonest before you can use!  Ex:

    Echonest.setup do |config|
      config.api_key = 'xxxx'
    end
eos
  end

  def self.config
    if @config
      @config
    else
      raise ConfigError, ConfigError::ERROR_TEXT
    end
  end

  def self.setup(&block)
    @config = Config.new
    yield @config
  end


end
