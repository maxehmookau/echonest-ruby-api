require 'spec_helper'
require 'base'

describe Echonest::Artist do

  def create_valid_artist
    @a = Echonest::Artist.new('Weezer', 'BNOAEBT3IZYZI6WXI')
  end

  it 'should allow an Artist to have a name' do
    a = Echonest::Artist.new('Weezer', '12345')
    a.name.should eql 'Weezer'
  end

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

  it 'should download a specified number of blogs' do
    create_valid_artist
    @a.blogs(results: 10).count.should be 10
  end

  it 'should return one blog by default' do
    create_valid_artist
    @a.blogs.count.should be 1
  end

  it 'should allow us to find out how familiar an artist is' do
    create_valid_artist
    @a.familiarity.should be_a Float
  end

end