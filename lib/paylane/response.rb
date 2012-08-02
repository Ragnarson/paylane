module PayLane
  class Response
    def initialize(soap_response_hash)
      @response = soap_response_hash
    end

    def [](key)
      @response[key]
    end

    def success?
      !@response[:ok].nil?
    end

    def error?
      !success?
    end

    def error_description
       @response[:error][:error_description] if error?
    end
  end
end
