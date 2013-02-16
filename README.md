# echonest-ruby-api [![Code Climate](https://codeclimate.com/github/maxehmookau/echonest-ruby-api.png)](https://codeclimate.com/github/maxehmookau/echonest-ruby-api)
[![Build Status](https://travis-ci.org/maxehmookau/echonest-ruby-api.png)](https://travis-ci.org/maxehmookau/echonest-ruby-api)
[![Dependency Status](https://gemnasium.com/maxehmookau/echonest-ruby-api.png)](https://gemnasium.com/maxehmookau/echonest-ruby-api)
TODO: Everything. (also, come up with a cool name)

## Installation

Add this line to your application's Gemfile:

    gem 'echonest-ruby-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install echonest-ruby-api


## Usage

Require the gem in your file:

    require 'echonest-ruby-api'

### Artist


Create an instance of an object

    artist = Echonest::Artist.new('Weezer', 'YOUR-API-KEY')

Then you have access to a bunch of methods:

    artist.name
    artist.biographies
    artist.blogs
    artist.familiarity
    artist.hotttnesss
    artist.images
    artist.songs



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
