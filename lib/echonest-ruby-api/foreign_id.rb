module Echonest
  class ForeignId

    attr_accessor :catalog, :foreign_id, :catalog_id

    def initialize(options = {})
      @catalog = options[:catalog]
      @foreign_id = options[:foreign_id]
      @catalog_id = foreign_id.split(":").last
    end

    def self.parse_array(array = [])
      foreign_ids = []
      array.each do |fid|
        foreign_ids << ForeignId.new(fid)
      end
      foreign_ids
    end
  end
end