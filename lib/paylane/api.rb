module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      PayLane::Response.new do
        request(:multiSale, params, 'multi_sale_params')[:multi_sale_response][:response]
      end
    end

    def capture_sale(params)
      PayLane::Response.new do
        request(:captureSale, params)[:capture_sale_response][:response]
      end
    end

    def close_sale_authorization(params)
      PayLane::Response.new do
        request(:closeSaleAuthorization, params)[:close_sale_authorization_response][:response]
      end
    end

    def refund(params)
      PayLane::Response.new do
        request(:refund, params)[:refund_response][:response]
      end
    end

    def resale(params)
      PayLane::Response.new do
        request(:resale, params)[:resale_response][:response]
      end
    end

    def get_sale_result(params)
      PayLane::Response.new do
        request(:getSaleResult, params)[:get_sale_result_response][:response]
      end
    end

    def check_sales(params)
      PayLane::Response.new do
        request(:checkSales, params, 'check_sales_params')[:check_sales_response][:check_sales_response]
      end
    end

    private

    def request(method, params, params_prefix = nil)
      body = params_prefix ? {params_prefix => params} : params
      soap_response = @client.request(method) { soap.body = body }
      soap_response.to_hash
    end
  end
end

