class Biography

  def initialize(options = {})
    @text = options[:text]
    @site = options[:site]
    @url = options[:url]
  end

  def text
    @text
  end

  def site
    @site
  end

  def url
    @url
  end

end