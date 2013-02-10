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

  end
end