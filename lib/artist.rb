require "rubygems"
require "bundler/setup"
require 'httparty'
require 'multi_json'
require_relative 'base'
require_relative 'biography'

module Echonest
  class Artist < Base

    def initialize(name, api_key)
      @name = name
      @api_key = api_key
    end

    def name
      @name
    end

    def biographies(options = {})
      response = get(endpoint: 'artist/biographies', results: options[:results])
      biographies = []
      response[:response][:biographies].each do |b|
        biographies << Biography.new(text: b[:text], site: b[:site], url: b[:url])
      end
      biographies
    end

  end
end