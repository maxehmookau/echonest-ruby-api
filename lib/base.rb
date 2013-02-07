class Base

  def initialize(api_key)
    @api_key = api_key
    @base_uri = "http://developer.echonest.com/api/v4/"
  end

  def self.base_uri
    "http://developer.echonest.com/api/v4/"
  end

  def get(options = {})
    response = HTTParty.get("#{ Base.base_uri }#{ options[:endpoint] }?api_key=#{ @api_key }&format=json&results=#{ options[:results] }&name=#{ @name }")
    MultiJson.load(response.body, symbolize_keys: true)
  end

end