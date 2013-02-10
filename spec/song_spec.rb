require 'spec_helper'
require 'base'

describe Song do

  def create_valid_song_object
    @song = Song.new('BNOAEBT3IZYZI6WXI')
  end


  it 'should allow initialization' do
    create_valid_song_object
    @song.should be
  end

  # describe '#search' do

  #   it 'should perform a search with a hash of options' do
  #     create_valid_song_object
  #     params = { title: 'Hello' }
  #     @song.search(params).should be_a Array
  #   end

  # end

end