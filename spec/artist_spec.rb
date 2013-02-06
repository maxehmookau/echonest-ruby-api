require 'spec_helper'
require 'base'

describe Echonest::Artist do

  it 'should allow an Artist to have a name' do
    a = Echonest::Artist.new('Weezer', '12345')
    a.name.should eql 'Weezer'
  end

  it 'should download a specified number of biographies' do
    a = Echonest::Artist.new('Weezer', 'BNOAEBT3IZYZI6WXI')
    a.biographies(results: 10).count.should be 10
  end

end