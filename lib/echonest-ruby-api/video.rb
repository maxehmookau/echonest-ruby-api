module Echonest
  class Video
    attr_accessor :title, :site, :url, :date_found, :image_url
    def initialize(options = {})
      @title = options[:title]
      @site = options[:site]
      @url = options[:url]
      @date_found = options[:date_found]
      @image_url = options[:image_url]
    end
  end
end
