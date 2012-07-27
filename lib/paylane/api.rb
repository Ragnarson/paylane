module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      do_request(:multiSale, params, 'multi_sale_params')[:multi_sale_response][:response]
    end

    def capture_sale(params)
      do_request(:captureSale, params)[:capture_sale_response][:response]
    end

    def close_sale_authorization(params)
      do_request(:closeSaleAuthorization, params)[:close_sale_authorization_response][:response]
    end

    def refund(params)
      do_request(:refund, params)[:refund_response][:response]
    end

    def resale(params)
      do_request(:resale, params)[:resale_response][:response]
    end

    def get_sale_result(params)
      do_request(:getSaleResult, params)[:get_sale_result_response][:response]
    end

    def check_sales(params)
      do_request(:checkSales, params, 'check_sales_params')[:check_sales_response][:check_sales_response]
    end

    private

    def do_request(method, params, params_prefix = nil)
      body = params_prefix ? {params_prefix => params} : params
      soap_response = @client.request(method) { soap.body = body }
      PayLane::Response.new(soap_response.to_hash)
    end
  end
end


