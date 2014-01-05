module Echonest
  class Blog

    attr_accessor :name, :summary, :url, :date_posted
    def initialize(options = {})
      @name = options[:name]
      @summary = options[:summary]
      @url = options[:url]
      @date_posted = options[:date_posted]
    end

  end
end