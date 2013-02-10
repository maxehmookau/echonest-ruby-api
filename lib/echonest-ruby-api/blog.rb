class Blog
  def initialize(options = {})
    @name = options[:name]
    @summary = options[:summary]
    @url = options[:url]
    @date_posted = options[:date_posted]
  end

  def name
    @name
  end

  def summary
    @summary
  end

  def url
    @url
  end

  def date_posted
    @date_posted
  end
end