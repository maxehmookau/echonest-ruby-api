class Base
  class EchonestConnectionError < Exception; end

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

    json = MultiJson.load(response.body, symbolize_keys: true)
    response_code = json[:response][:status][:code]

    if response_code.eql? 0
      json
    else
      raise ArgumentError, "Echonest responded with an error of code #{ response_code }"
    end
  end

end