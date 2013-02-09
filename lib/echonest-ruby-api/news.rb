class News

  def initialize(options = {})
    @name = options[:name]
    @url = options[:url]
    @date_posted = options[:date_posted]
    @summary = options[:summary]
  end

  def name
    @name
  end

  def url
    @url
  end

  def date_posted
    @date_posted
  end

  def summary
    @summary
  end

end