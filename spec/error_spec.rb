require 'spec_helper'

describe Echonest::Error do

  describe '#initialize' do

    it 'should accept an error code as the only parameter' do
      err = Echonest::Error.new(3)
    end

  end

  describe '#description' do

    it 'should return the errors description' do
      err = Echonest::Error.new(5)
      err.description.should eql 'Invalid parameter'
    end

  end

end