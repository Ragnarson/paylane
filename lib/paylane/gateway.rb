require 'savon'

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
        http.headers["Authorization"] = authorization_header
      end
    end

    def wsdl_location
      'https://direct.paylane.com/wsdl/production/Direct.wsdl'
    end

    def authorization_header
      "Basic #{encoded_credentails}"
    end

    def encoded_credentails
      Base64.encode64(credentials)
    end

    def credentials
      [@login, @password].join(':')
    end
  end
end
