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

    def get_sale_result(params)
      response = @client.request(:getSaleResult) do
        soap.body = params
      end
      response.to_hash[:get_sale_result_response][:response]
    end
  end
end


