require 'spec_helper'

describe ArtistResult do

  it 'should parse an array of results' do
    results = [{id: "123", name: "Ty Segall"},{id: "456", name: "Thee Oh Sees"}]
    ArtistResult.parse_array(results).count.should be 2
  end

end