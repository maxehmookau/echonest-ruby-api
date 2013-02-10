require 'spec_helper'

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
 
  end
  
end