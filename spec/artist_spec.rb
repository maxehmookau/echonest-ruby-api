require 'spec_helper'
require 'base'

describe Echonest::Artist do

  def create_valid_artist
    @a = Echonest::Artist.new('BNOAEBT3IZYZI6WXI', 'Weezer')
  end


  it 'should allow an Artist to have a name' do
    a = Echonest::Artist.new('12345', 'Weezer')
    a.name.should eql 'Weezer'
  end

  describe '#entity_name' do

    it 'should always return artist' do
      a = Echonest::Artist.new('Weezer', '12345')
      a.entity_name.should eql 'artist'
    end

  end

  describe '#biographies' do

    it 'should download a specified number of biographies' do
      create_valid_artist
      @a.biographies(results: 10).count.should be 10
    end

    it 'should return one biography by default' do
      create_valid_artist
      @a.biographies.count.should be 1
    end

    it 'should deal gracefully with an invalid API key' do
      a = Echonest::Artist.new('Weezer', 'THISISNOTAKEY')
      expect { a.biographies }.to raise_error(ArgumentError)
    end

  end

  describe '#blogs' do

    it 'should download a specified number of blogs' do
      create_valid_artist
      @a.blogs(results: 10).count.should be 10
    end

    it 'should return one blog by default' do
      create_valid_artist
      @a.blogs.count.should be 1
    end

  end

  describe '#familiarity' do

    it 'should allow us to find out how familiar an artist is' do
      create_valid_artist
      @a.familiarity.should be_a Float
    end

  end

  describe '#hotttnesss' do

    it 'should allow us to find out how hotttt an artist is' do
      create_valid_artist
      @a.hotttnesss.should be_a Float
    end

  end

  describe '#images' do

    it 'should allow us to get an array of urls' do
      create_valid_artist
      @a.images.should be_a Array
    end

    it 'should only return urls in the array' do
      create_valid_artist
      @a.images.each do |i|
        i.should match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
      end
    end

  end

  describe '#list_genres' do

    it 'should return an array of acceptable genres' do
      create_valid_artist
      @a.list_genres.should be_a Array
    end

    it 'should return an array in the correct format' do
      create_valid_artist
      @a.list_genres.each do |g|
        g[:name].should be_a String
      end
    end

  end

  describe '#songs' do

    it 'should return an Array of a Hash of songs' do
      create_valid_artist
      @a.songs.should be_a Array
    end

    it 'should return a valid hash for each song' do
      create_valid_artist
      @a.songs.each do |k|
        k.should be_a Hash
      end
    end

  end

end