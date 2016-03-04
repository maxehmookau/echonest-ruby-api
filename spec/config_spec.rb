require 'spec_helper'

module Echonest

  describe Config do

    it 'should raise Error if not configured' do
      Echonest.instance_variable_set(:@config, nil)
      expect { Echonest.config }.to raise_error(ConfigError)
    end

    it 'should return the api key after configured' do 
      Echonest.setup do |config|
        config.api_key = 'da_key'
      end
      Echonest.config.api_key.should eql 'da_key'
    end

  end

end