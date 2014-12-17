require 'rubygems'
require 'bundler/setup'
require_relative 'base'

module Echonest
  class Genre < Echonest::Base
    attr_accessor :name

    def initialize(api_key, name = nil)
      @api_key = api_key
      @name = name
    end

    def artists(options = {})
      get_response(options.merge(name: @name))
    end

    def profile(options = {})
      get_response(options.merge(name: @name))
    end

    def similar(options = {})
      get_response(options.merge(name: @name))
    end

    def self.list(api_key, options = {})
      parent.get_api_endpoint(api_key, 'genre/list', options)
    end

    def self.search(api_key, options = {})
      parent.get_api_endpoint(api_key, 'genre/search', options)
    end
  end
end
