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

    def identify(code)
      raise ArgumentError, 'Not a valid Echoprint or ENFMP fingerprint' if code.empty?
      response = get_response(code: code)
      results = []
      response[:songs].each do |song|
        results << { score: song[:score], title: song[:title], artist_name: song[:artist_name] }
      end
      results
    end

    # Generates an acoustic fingerprint using the echoprint-codegen
    # binary.
    #
    # Examples:
    #     echoprint_code('path/to/song.mp3')
    #     #=> Echoprint code as String 
    #
    # Raises an +Echoprint::Error+ if the echoprint-codegen binary
    # is not accessible to Ruby on $PATH
    #
    # * +filepath+ - Path (absolute or relative) to an audio file atleast 21 seconds in length
    # 
    # Returns a String
    def echoprint_code(filepath)
      if which('echoprint-codegen').nil?
        error = Error.new(6)
        raise Error.new(6), error.description
      else
        response = `echoprint-codegen #{ filepath } 1 20`
        JSON.parse(response)[0]['code']
      end
    end

  end
end