require "rubygems"
require "bundler/setup"
require_relative 'base'

module Echonest
  
  class Playlist < Echonest::Base

    def initialize(api_key, artist) 
      @api_key = api_key
      @artist = artist
      @type = 'artist-radio'
      response = get('playlist/dynamic/create', 
        { artist: @artist, type: @type })
      @session_id = response[:session_id]
    end

    def next
      response = get('playlist/dynamic/next', { session_id: session_id })
      artist = Echonest::Artist.new(@api_key, response[:songs].first[:artist_name])
      { :artist => artist, :track => response[:songs].first[:title] }
    end

    def session_id
      @session_id
    end

  end
  
end
