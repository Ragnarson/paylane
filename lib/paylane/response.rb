module PayLane
  class Response
    def initialize(soap_response_hash)
      @soap_response_hash = soap_response_hash
    end

    def [](key)
      @soap_response_hash[key]
    end

    def success?
      !@soap_response_hash[:ok].nil?
    end
  end
end
