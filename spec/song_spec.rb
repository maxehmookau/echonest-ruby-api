require 'spec_helper'
require 'mocha/setup'

describe Echonest::Song do

  it 'should initialize correct' do
    a = Echonest::Song.new('abc234')
    a.should be_a Echonest::Song
  end

  describe '#search' do

    it 'should return an array of tracks' do
      a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
      options = { title: 'Hello' }
      a.search(options).should be_a Array
    end

    it 'should have the expected parameters' do
      a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
      options = { title: 'Hello' }
      a.search(options).each do |song|
        song.keys.should include :id, :artist_id, :artist_name, :title
      end
    end

    it 'should happily find slow songs' do
      a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
      options = { max_tempo: 60 }
      a.search(options).each do |song|
        song.keys.should include :id, :artist_id, :artist_name, :title
      end
    end
    
    # TODO: Write some comprehensive tests to make sure this breaks
    # if the API ever changes.
    # http://developer.echonest.com/docs/v4/song.html#search

  end

  describe '#identify' do

    it 'should identify billie jean with ease' do
      a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
      result = a.identify('eJxVlIuNwzAMQ1fxCDL133-xo1rnGqNAEcWy_ERa2aKeZmW9ustWVYrXrl5bthn_laFkzguNWpklEmoTB74JKYZSPlbJ0sy9fQrsrbEaO9W3bsbaWOoK7IhkHFaf_ag2d75oOQSZczbz5CKA7XgTIBIXASvFi0A3W8pMUZ7FZTWTVbujCcADlQ_f_WbdRNJ2vDUwSF0EZmFvAku_CVy440fgiIvArWZZWoJ7GWd-CVTYC5FCFI8GQdECdROE20UQfLoIUmhLC7IiByF1gzbAs3tsSKctyC76MPJlHRsZ5qhSQhu_CJFcKtW4EMrHSIrpTGLFqsdItj1H9JYHQYN7W2nkC6GDPjZTAzL9dx0fS4M1FoROHh9YhLHWdRchQSd_CLTpOHkQQP3xQsA2-sLOUD7CzxU0GmHVdIxh46Oide0NrNEmjghG44Ax_k2AoDHsiV6WsiD6OFm8y-0Lyt8haDBBzeMlAnTuuGYIB4WA2lEPAWbdeOabgFN6TQMs6ctLA5fHyKMBB0veGrjPfP00IAlWNm9n7hEh5PiYYBGKQDP-x4F0CL8HkhoQnRWN997JyEpnHFR7EhLPQMZmgXS68hsHktEVErranvSSR2VwfJhQCnkuwhBUcINNY-xu1pmw3PmBqU9-8xu0kiF1ngOa8vwBSSzzNw==')
      result.should be_a Array
      result.first[:artist_name].should eql 'Michael Jackson'
    end

    it 'should raise ArgumentError if the code is blank' do
      a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
      expect { a.identify() }.to raise_error(ArgumentError)
    end

  end

  describe '#echoprint_code' do
    # This is all very hard to test in a sensible way since it relies on
    # a binary existing on the users machine.

    # it 'should raise Exception if echoprint-codegen binary is not present' do
    #   a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
    #   a.stubs(:which).returns(nil)
    #   expect { a.echoprint_code('path-to-mp3') }.to raise_error(Echonest::Error)
    # end

    # it 'should call the echoprint-binary if it exists' do
    #   a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
    #   a.echoprint_code('/Users/maxwoolf/Desktop/example.mp3')
    # end

    # it 'should return a massive string if it was successful' do
    #   a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
    #   a.echoprint_code('/Users/maxwoolf/Desktop/example.mp3').should be_a String
    #   a.echoprint_code('/Users/maxwoolf/Desktop/example.mp3').length.should be > 400
    # end

    # it 'should identify a song using a generated code' do
    #   a = Echonest::Song.new('BNOAEBT3IZYZI6WXI')
    #   code = a.echoprint_code('/Users/maxwoolf/Desktop/example.mp3')
    #   puts code
    #   puts
    # end
  end

  
end