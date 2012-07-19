module PayLane
  class Configuration
    class << self
      attr_accessor :currency, :login, :password

      def currency
        'EUR'
      end

      def login
        "paylane_test_public"
      end

      def password
        "p2y12n3t3st"
      end
    end
  end
end

