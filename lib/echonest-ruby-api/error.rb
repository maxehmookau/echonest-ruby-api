module Echonest

  class Error < Exception
    attr_reader :error_code, :response

    ERRORS = { '-1' => 'Unknown Error',
               '0' => 'Success',
               '1' => 'Invalid/Missing API Key',
               '2' => 'This API key is not allowed to call that method',
               '3' => 'Rate limit exceeded',
               '4' => 'Missing parameter',
               '5' => 'Invalid parameter',
               '6' => 'Missing echoprint-codegen binary on $PATH'
             }

    def initialize(error_code, response = nil)
      @error_code = error_code
      @response = response
    end

    def description
      ERRORS[@error_code.to_s]
    end

    def details
      if error_code == 3
        # Returns a hash similar to {"remaining"=>0, "limit"=>20, "used"=>29}.
        Hash[response.headers.select{|k,v| k =~ /x-ratelimit/}.
          map{|k,v| [k.sub('x-ratelimit-', ''), v.first.to_i] }]
      end
    end

  end

end
