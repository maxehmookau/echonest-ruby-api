# echonest-ruby-api [![Code Climate](https://codeclimate.com/github/maxehmookau/echonest-ruby-api.png)](https://codeclimate.com/github/maxehmookau/echonest-ruby-api) [![Build Status](https://travis-ci.org/maxehmookau/echonest-ruby-api.png)](https://travis-ci.org/maxehmookau/echonest-ruby-api) [![Dependency Status](https://gemnasium.com/maxehmookau/echonest-ruby-api.png)](https://gemnasium.com/maxehmookau/echonest-ruby-api)


![Echonest] (http://the.echonest.com/static/img/logos/250x80_lt.gif)

**echonesst-ruby-api** is a pure Ruby wrapper around the Echonest APIs. 

## Requirements
* An API Key (available free)
* Ruby 1.9.3+
* [echonest/echoprint-codegen](https://github.com/echonest/echoprint-codegen) binary in your `$PATH` if you want to identify audio files. (yeah, *identify!*)

## Installation

In your Gemfile:

    gem 'echonest-ruby-api'
    
and then `bundle install`

Or install locally:

    $ (sudo) gem install echonest-ruby-api


## Usage

Require the gem in your file:

    require 'echonest-ruby-api'

## Artist

Create an instance of an object

    artist = Echonest::Artist.new('YOUR-API-KEY', 'Weezer')

Then you have access to a bunch of methods:

    artist.name
    artist.biographies
    artist.blogs
    artist.familiarity
    artist.hotttnesss
    artist.images
    artist.songs
    
*Exact response are specified in the RDoc  but the method names try to be as self-explanatory as possible.*

## Song

Create an instance of the Song module.

    song = Echonest::Song.new('YOUR-API-KEY')

Then you have access to the song/search endpoint:
*(this is where it gets clever)*

    params = { mood: "sad^.5", results: 10, min_tempo: 130, max_tempo: 150 }
    song.search(params)

See the full list of params [here](http://developer.echonest.com/docs/v4/song.html#search)

## Identification

> **Note:** This stuff is flakey as hell. Seems to work pretty well on OSX, but it doesn't work out of the box. You'll need to follow these instructions to get it working.

You can even **identify** a song simply from its fingerprint! Support for this is flaky so far and only tested on OS X.

Firstly, make sure that the `echoprint-codegen` binary is available on your local `$PATH`. 
    
Just run: `echoprint-codegen` on the terminal and see if it returns anything other than an error.
    
If it's not installed, you'll need to compile it from source. **It's not as scary as it sounds.**


    brew install ffmpeg boost taglib # Install dependencies
    
    cd ~/Desktop/ # or somewhere else sensible, you can delete it later anyway
    
    git clone https://github.com/echonest/echoprint-codegen.git
    
    cd echoprint-codegen
    
    make
    
    make install
    
This should then allow you to use the `echoprint-codegen` command at the command line. If not, try following the instructions here: [echonest/echoprint-codegen](https://github.com/echonest/echoprint-codegen)

Then just use this method call:

    song = Echonest::Song.new('YOUR-API-KEY')
    code = song.echoprint_code('path/to/audio/file')
    puts code.identify(code)

If there's a positive match, it'll return something like this:

    {
      "response": {
            "status": {
            "code": 0,
            "message": "Success",
            "version": "4.2"
          },
          "songs": [
          {
            "title": "Billie Jean",
            "artist_name": "Michael Jackson",
            "artist_id": "ARXPPEY1187FB51DF4",
            "score": 49,
            "message": "OK (match type 5)",
            "id": "SOKHYNL12A8C142FC7"
          }
        ]
      }
    }

Checkout `spec/song_spec.rb` for an example code to test it out. 

Note that this calls the song/identify API endpoint and does *not* support other Echoprint servers.

## Testing

Testing is done using RSpec. Just run `guard` in the root directory and it'll run the tests automatically. Use `vcr` to mock responses from the Echonest servers.

## Contributors

* Max Woolf (me!)
* abdyer
* garethrees
* jordanpoulton
* makersacademy
* deadroxy
