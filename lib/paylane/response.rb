module PayLane
  class Response < Hash
    def initialize(soap_response_hash)
      @response = soap_response_hash
    end

    def [](key)
      @response[key]
    end

    def has_ok?
      @response.include?(:ok)
    end

    def has_error?
      !has_ok?
    end

    def has_data?
      @response.include?(:data)
    end

    def error_description
       @response[:error][:error_description] if has_error?
    end

    def attributes
      hash = (@response[:ok] || @response[:error])
      has_data? ? hash.merge(@response[:data]) : hash
    end

    def to_s
      @response.to_s
    end
  end
end
