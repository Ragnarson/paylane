module PayLane
  class Product
    def initialize(attributes)
      @attributes = attributes
    end

    def description
      attributes = Array(@attributes) << Time.now.getutc
      attributes.map { |a| "[#{a}]" }.join ''
    end
  end
end

