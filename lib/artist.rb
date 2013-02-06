require "rubygems"
require "bundler/setup"
require 'httparty'
require 'multi_json'
require_relative 'biography'

class Artist < Base

  def initialize(name, api_key)
    @name = name
    @api_key = api_key
  end

  def biographies
    endpoint = 'artist/biographies'
    response = HTTParty.get("#{ Base.base_uri }#{ endpoint }?api_key=#{ @api_key }&format=json&results=100&name=#{ @name }")
    json = MultiJson.load(response.body, symbolize_keys: true)
    biographies = []
    json[:response][:biographies].each do |b|
      biographies << Biography.new(text: b[:text], site: b[:site], url: b[:url])
    end
    biographies
  end


end