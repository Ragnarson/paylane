module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      do_request(:multiSale, params, 'multi_sale_params')
        .to_hash[:multi_sale_response][:response]
    end

    def capture_sale(params)
      do_request(:captureSale, params)
        .to_hash[:capture_sale_response][:response]
    end

    def close_sale_authorization(params)
      do_request(:closeSaleAuthorization, params)
        .to_hash[:close_sale_authorization][:response]
    end

    def resale(params)
      do_request(:resale, params)
        .to_hash[:resale_response][:response]
    end

    def get_sale_result(params)
      do_request(:getSaleResult, params)
        .to_hash[:get_sale_result_response][:response]
    end

    def check_sales(params)
      do_request(:checkSales, params, 'check_sales_params')
        .to_hash[:check_sales_response][:check_sales_response]
    end

    private

    def do_request(method, params, params_prefix = nil)
      body = params_prefix ? {params_prefix => params} : params
      @client.request(method) { soap.body = body }
    end
  end
end


