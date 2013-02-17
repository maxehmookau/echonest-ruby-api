module Echonest

  class Error < Exception
    ERRORS = { '-1' => 'Unknown Error', 
               '0' => 'Success',
               '1' => 'Invalid/Missing API Key',
               '2' => 'This API key is not allowed to call that method',
               '3' => 'Rate limit exceeded',
               '4' => 'Missing parameter',
               '5' => 'Invalid parameter',
               '6' => 'Missing echoprint-codegen binary on $PATH'
             }


    # Create a new Echonest::Error object
    def initialize(error_code)
      @error_code = error_code
    end

    
    def description
      ERRORS[@error_code.to_s]
    end

  end

end