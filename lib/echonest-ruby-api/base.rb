require 'httparty'
require 'multi_json'

module Echonest
  class Base
    class EchonestConnectionError < Exception; end

    def initialize(api_key)
      @api_key = api_key
      @base_uri = "http://developer.echonest.com/api/v4/"
    end

    def get_response(options = {})
      get(endpoint, options)
    end

    def entity_name
      self.class.to_s.split('::').last.downcase
    end

    def endpoint
      calling_method = caller[1].split('`').last[0..-2]
      "#{ entity_name }/#{ calling_method }"
    end

    # Gets the base URI for all API calls
    #
    # Returns a String
    def self.base_uri
      "http://developer.echonest.com/api/v#{ Base.version }/"
    end

    # The current version of the Echonest API to be supported.
    #
    # Returns a Fixnum
    def self.version
      4
    end

    # Performs a simple HTTP get on an API endpoint.
    #
    # Examples:
    #     get('artist/biographies', results: 10)
    #     #=> Array of Biography objects.
    #
    # Raises an +ArgumentError+ if the Echonest API responds with
    # an error.
    #
    # * +endpoint+ - The name of an API endpoint as a String
    # * +options+ - A Hash of options to pass to the end point.
    #
    # Returns a response as a Hash
    def get(endpoint, options = {})
      query_string = ""
      options.each do |key, value|
        query_string << "#{ key }=#{ value }&"
      end
      #puts "#{ Base.base_uri }#{ endpoint }?api_key=#{ @api_key }&format=json&#{ query_string }"
      response = HTTParty.get("#{ Base.base_uri }#{ endpoint }?api_key=#{ @api_key }&format=json&#{ query_string }")
      json = MultiJson.load(response.body, symbolize_keys: true)
      response_code = json[:response][:status][:code]

      response_code.eql?(0) ? json[:response] : raise(Echonest::Error.new(response_code), "Error code #{ response_code }")

    end

  end
end