module PayLane
  class ConnectionError < StandardError
    attr_reader :soap_error

    def initialize(soap_error)
      @soap_error = soap_error
    end

    def to_s
      @soap_error.to_s
    end
  end
end
