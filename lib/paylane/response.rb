module PayLane
  class Response
    def initialize(soap_response_hash)
      @response = soap_response_hash
    end

    def [](key)
      @response[key]
    end

    def has_ok?
      !@response[:ok].nil?
    end

    def has_error?
      !has_ok?
    end

    def error_description
       @response[:error][:error_description] if has_error?
    end
  end
end
