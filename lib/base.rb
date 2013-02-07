class Base

  def initialize(api_key)
    @api_key = api_key
    @base_uri = "http://developer.echonest.com/api/v4/"
  end

  def self.base_uri
    "http://developer.echonest.com/api/v#{ Base.version }/"
  end

  def self.version
    4
  end

  def get(endpoint, options = {})
    query_string = ""
    options.each do |key, value|
      query_string << "#{ key }=#{ value }&"
    end
    response = HTTParty.get("#{ Base.base_uri }#{ endpoint }?api_key=#{ @api_key }&format=json&#{ query_string }")

    MultiJson.load(response.body, symbolize_keys: true)
  end

end