require 'base'
require "rubygems"
require "bundler/setup"
require 'httparty'
require 'multi_json'


module Echonest
  class Song < Echonest::Base

    def initialize(api_key)
      @api_key = api_key
    end

    def search(options = {})
      # response = get_response(results: options[:results], name: @name)
    end

  end
end