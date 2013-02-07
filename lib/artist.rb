require "rubygems"
require "bundler/setup"
require 'httparty'
require 'multi_json'
require_relative 'base'
require_relative 'biography'
require_relative 'blog'

module Echonest
  class Artist < Base

    def initialize(name, api_key)
      @name = name
      @api_key = api_key
    end

    def name
      @name
    end

    def biographies(options = { results: 1 })
      response = get('artist/biographies', results: options[:results], name: @name)
      biographies = []
      response[:response][:biographies].each do |b|
        biographies << Biography.new(text: b[:text], site: b[:site], url: b[:url])
      end
      biographies
    end

    def blogs(options = { results: 1 })
      response = get('artist/blogs', results: options[:results], name: @name)
      blogs = []
      response[:response][:blogs].each do |b|
        blogs << Blog.new(name: b[:name], site: b[:site], url: b[:url])
      end
      blogs
    end

  end
end