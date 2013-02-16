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

    # Cross-platform way of finding an executable in the $PATH.
    #
    #   which('ruby') #=> /usr/bin/ruby
    def which(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
          exe = File.join(path, "#{ cmd }#{ ext }")
          return exe if File.executable? exe
        }
      end
      return nil
    end

    def echoprint_code(audio)
      if which('echoprint-codegen').nil?
        raise Error.new(1), 'Install echoprint-codegen!'
      else
        response = `echoprint-codegen #{ audio }`
        puts JSON.parse(response).to_json.keys
      end
    end

  end
end