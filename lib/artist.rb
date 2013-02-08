require "rubygems"
require "bundler/setup"
require 'httparty'
require 'multi_json'
require_relative 'base'

module Echonest
  class Artist < Echonest::Base

    def initialize(name, api_key)
      @name = name
      @api_key = api_key
    end

    def name
      @name
    end

    def entity_name
      self.class.to_s.split('::').last.downcase
    end

    def get_response(options = {})
      get(endpoint, options)
    end

    def endpoint
      calling_method = caller[1].split('`').last[0..-2]
      "#{ entity_name }/#{ calling_method }"
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

  end
end