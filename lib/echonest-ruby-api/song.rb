require "rubygems"
require "bundler/setup"
require 'httparty'
require 'multi_json'
require_relative 'base'

module Echonest
  class Song < Echonest::Base

    def initialize(api_key)
      @api_key = api_key
    end

    def search(options = {})
      defaults = { api_key: @api_key }
      response = get_response(options)
      songs = []
      response[:songs].each do |song|
        songs << song
      end
    end

  end
end