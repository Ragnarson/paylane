module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      PayLane::Response.new(request(:multiSale, params, 'multi_sale_params')[:multi_sale_response][:response])
    end

    def capture_sale(params)
      PayLane::Response.new(request(:captureSale, params)[:capture_sale_response][:response])
    end

    def close_sale_authorization(params)
      PayLane::Response.new(request(:closeSaleAuthorization, params)[:close_sale_authorization_response][:response])
    end

    def refund(params)
      PayLane::Response.new(request(:refund, params)[:refund_response][:response])
    end

    def resale(params)
      PayLane::Response.new(request(:resale, params)[:resale_response][:response])
    end

    def get_sale_result(params)
      PayLane::Response.new(request(:getSaleResult, params)[:get_sale_result_response][:response])
    end

    def check_sales(params)
      PayLane::Response.new(request(:checkSales, params, 'check_sales_params')[:check_sales_response][:check_sales_response])
    end

    private

    def request(method, params, params_prefix = nil)
      body = params_prefix ? {params_prefix => params} : params
      soap_response = @client.request(method) { soap.body = body }
      soap_response.to_hash
    end
  end
end

