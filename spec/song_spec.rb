require 'spec_helper'

describe Echonest::Song do

  it 'should create ok' do
    a = Echonest::Song.new('abc234')
    a.should be
  end
  
end