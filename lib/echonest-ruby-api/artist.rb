require "rubygems"
require "bundler/setup"
require_relative 'base'
require_relative 'blog'
require_relative 'biography'

module Echonest

  class Artist < Echonest::Base

    def initialize(api_key, name = nil)
      @name = name
      @api_key = api_key
    end

    def name
      @name
    end

    def biographies(options = { results: 1 })
      response = get_response(results: options[:results], name: @name)
      biographies = []
      response[:biographies].each do |b|
        biographies << Biography.new(text: b[:text], site: b[:site], url: b[:url])
      end
      biographies
    end

    def blogs(options = { results: 1 })
      response = get_response(results: options[:results], name: @name)
      blogs = []
      response[:blogs].each do |b|
        blogs << Blog.new(name: b[:name], site: b[:site], url: b[:url])
      end
      blogs
    end

    def familiarity
      response = get_response(name: @name)
      response[entity_name.to_sym][__method__.to_sym]
    end

    def hotttnesss
      response = get_response(name: @name)
      response[entity_name.to_sym][__method__.to_sym]
    end

    def images
      response = get_response(name: @name)
      images = []
      response[:images].each do |i|
        images << i[:url]
      end
      images
    end

    def list_genres
      get_response[:genres]
    end

    def songs
      songs = []
      get_response(name: @name)[:songs].each do |s|
        songs << { s[:id] => s[:title] }
      end
      songs
    end

  end
end