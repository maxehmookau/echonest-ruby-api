require_relative 'foreign_id'

class ArtistResult
  
  attr_accessor :id, :name, :foreign_ids

  def initialize(options = {})
    @id = options[:id]
    @name = options[:name]
    @foreign_ids = ForeignId.parse_array(options[:foreign_ids]) if options[:foreign_ids]
  end

  def self.parse_array(array = [])
    results = []
    array.each do |artist|
      results << ArtistResult.new(artist)
    end
    results
  end
end