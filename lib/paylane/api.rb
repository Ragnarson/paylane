module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      response = @client.request(:multiSale) do
        soap.body = {'multi_sale_params' => params}
      end
      response.to_hash[:multi_sale_response][:response]
    end
  end
end


