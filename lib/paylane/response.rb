module PayLane
  class Response < Hash
    attr_reader :body

    def initialize(body)
      @body = body
    end

    def has_ok?
      @body.include?(:ok)
    end

    def has_error?
      !has_ok?
    end

    def has_data?
      @body.include?(:data)
    end

    def error_description
       @body[:error][:error_description] if has_error?
    end

    def attributes
      hash = (@body[:ok] || @body[:error])
      has_data? ? hash.merge(@body[:data]) : hash
    end
  end
end
