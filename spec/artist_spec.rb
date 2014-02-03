require 'spec_helper'

describe Echonest::Artist do

  def create_valid_artist
    @a = Echonest::Artist.new('BNOAEBT3IZYZI6WXI', 'Weezer')
  end

  def create_valid_artist_with_id
    @a = Echonest::Artist.new('BNOAEBT3IZYZI6WXI', nil, nil, 'ARH6W4X1187B99274F')
  end


  it 'should allow an Artist to have a name' do
    a = Echonest::Artist.new('12345', 'Weezer')
    a.name.should eql 'Weezer'
  end

  describe '#entity_name' do

    it 'should always return artist' do
      VCR.use_cassette('entity_name') do
        a = Echonest::Artist.new('Weezer', '12345')
        a.entity_name.should eql 'artist'
      end
    end

  end

  describe '#biographies' do

    it 'should download a specified number of biographies' do
      VCR.use_cassette('biographies') do
        create_valid_artist
        @a.biographies(results: 10).count.should be 10
      end
    end

    it 'should return one biography by default' do
      VCR.use_cassette('single_biography') do
        create_valid_artist
        @a.biographies.count.should be 1
      end
    end

    it 'should deal gracefully with an invalid API key' do
      VCR.use_cassette('invalid_api_key_error') do
        a = Echonest::Artist.new('Weezer', 'THISISNOTAKEY')
        expect { a.biographies }.to raise_error(Echonest::Error)
      end
    end

  end

  describe '#blogs' do

    it 'should download a specified number of blogs' do
      VCR.use_cassette('ten_blogs') do
        create_valid_artist
        @a.blogs(results: 10).count.should be 10
      end
    end

    it 'should return one blog by default' do
      VCR.use_cassette('blogs') do
        create_valid_artist
        @a.blogs.count.should be 1
      end
    end

  end

  describe '#familiarity' do

    it 'should allow us to find out how familiar an artist is' do
      VCR.use_cassette('familiarity') do
        create_valid_artist
        @a.familiarity.should be_a Float
      end
    end

  end

  describe '#hotttnesss' do

    it 'should allow us to find out how hotttt an artist is' do
      VCR.use_cassette('hotttnesss') do
        create_valid_artist
        @a.hotttnesss.should be_a Float
        @a.hotttnesss(type: 'social').should be_a Float
        @a.hotttnesss(type: 'reviews').should be_a Float
        @a.hotttnesss(type: 'mainstream').should be_a Float
      end
    end

  end

  describe '#images' do

    it 'should allow us to get an array of urls' do
      VCR.use_cassette('images') do
        create_valid_artist
        @a.images.should be_a Array
      end
    end

    it 'should allow Artists with whitespace in their names' do
      VCR.use_cassette('images_whitespace') do
        @a = Echonest::Artist.new('BNOAEBT3IZYZI6WXI', 'Bob Marley')
        @a.images.should be_a Array
      end
    end

    it 'should be able to fetch more than the default amount' do
      VCR.use_cassette('images_more') do
        @a = Echonest::Artist.new('BNOAEBT3IZYZI6WXI', 'Bob Marley')
        images = @a.images(results: 20)
        images.size.should be > 15
      end
    end

    it 'should only return urls in the array' do
      VCR.use_cassette('images') do
        create_valid_artist
        @a.images.each do |i|
          i.should match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/)
        end
      end
    end

  end

  describe '#list_genres' do

    it 'should return an array of acceptable genres' do
      VCR.use_cassette('list_genres') do
        create_valid_artist
        @a.list_genres.should be_a Array
      end
    end

    it 'should return an array in the correct format' do
      VCR.use_cassette('list_genres') do
        create_valid_artist
        @a.list_genres.each do |g|
          g[:name].should be_a String
        end
      end
    end

  end

  describe '#search' do
    it 'should return an Array of artists' do
      VCR.use_cassette('search') do
        create_valid_artist
        @a.search.should be_a Array
      end
    end

    it 'should return an Artist object for each result' do
      VCR.use_cassette('search') do
        create_valid_artist
        @a.search.each do |k|
          k.class.should be Echonest::Artist
        end
      end
    end

    it 'should fill in id of each returned artist' do
      VCR.use_cassette('search') do
        create_valid_artist
        @a.search.each do |k|
          k.id.should_not be_nil
        end
      end
    end

    it 'should search the specified bucket' do
      VCR.use_cassette('search_2') do
        create_valid_artist
        results = @a.search(bucket: "id:musicbrainz")
        foreign_id = results.first.foreign_ids.first
        foreign_id.catalog.should eq("musicbrainz")
      end
    end
  end

  describe '#songs' do

    it 'should return an Array of a Hash of songs' do
      VCR.use_cassette('songs') do
        create_valid_artist
        @a.songs.should be_a Array
      end
    end

    it 'should return a valid hash for each song' do
      VCR.use_cassette('songs') do
        create_valid_artist
        @a.songs.each do |k|
          k.should be_a Hash
        end
      end
    end

  end

  describe "#profile" do

    it 'should return an artist profile given an id' do
      VCR.use_cassette('profile') do
        @a = Echonest::Artist.new('BNOAEBT3IZYZI6WXI', nil, nil, 'ARH6W4X1187B99274F')
        artist = @a.profile
        artist.should be_a Echonest::Artist
        artist.name.should eq "Radiohead"
      end
    end

  end

  describe '#terms' do

    it 'should return an array of hashes of terms' do
      VCR.use_cassette('terms') do
        create_valid_artist_with_id
        @a.terms.should be_a Array
      end
    end

    it 'should return valid hash for each term' do
      VCR.use_cassette('terms') do
        create_valid_artist_with_id
        @a.terms.each do |k|
          k.should be_a Hash
        end
      end
    end

    it 'should return modern rock for Radiohead' do
      VCR.use_cassette('terms') do
        create_valid_artist_with_id
        @a.terms.map{|t| t[:name]}.should include("modern rock")
      end
    end

    it 'should work even when artist has both name and id' do
      # If we try, echonest will respond with error:
      # 'limit - Only one of \"name\" or \"id\" is allowed'
      VCR.use_cassette('terms') do
        create_valid_artist_with_id
        @a.name = "Weezer"
        expect {
          @a.terms
        }.to_not raise_error
      end
    end

  end
end
