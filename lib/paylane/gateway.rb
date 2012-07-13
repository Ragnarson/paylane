module PayLane
  class Gateway
    attr_reader :client

    def initialize(login, password)
      @login = login
      @password = password
    end

    def connect
      @client = Savon.client do |wsdl, http|
        wsdl.document = wsdl_location
        http.auth.basic(@login, @password)
      end
    end

    def wsdl_location
      'https://direct.paylane.com/wsdl/production/Direct.wsdl'
    end
  end
end
