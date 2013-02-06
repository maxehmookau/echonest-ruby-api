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
      allowed_params = [:results]
      endpoint = 'artist/biographies'
      response = HTTParty.get("#{ Base.base_uri }#{ endpoint }?api_key=#{ @api_key }&format=json&results=#{ options[:results] }&name=#{ @name }")
      json = MultiJson.load(response.body, symbolize_keys: true)
      biographies = []
      json[:response][:biographies].each do |b|
        biographies << Biography.new(text: b[:text], site: b[:site], url: b[:url])
      end
      biographies
    end



  end
end