class Biography

  attr_accessor :text, :site, :url

  def initialize(options = {})
    @text = options[:text]
    @site = options[:site]
    @url = options[:url]
  end

end