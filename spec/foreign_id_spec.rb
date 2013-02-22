require 'spec_helper'

describe ForeignId do

    it 'should parse the catalog id' do
      foreign_id = ForeignId.new(catalog: "musicbrainz", foreign_id: "musicbrainz:artist:6fe07aa5-fec0-4eca-a456-f29bff451b04")
      foreign_id.catalog_id.should eq("6fe07aa5-fec0-4eca-a456-f29bff451b04")
    end

    it 'should parse an array of results' do
      results = [{catalog: "musicbrainz", foreign_id: "123"},{catalog: "musicbrainz", foreign_id: "456"}]
      ForeignId.parse_array(results).count.should be 2
    end

end