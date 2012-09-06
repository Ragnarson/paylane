require "paylane/response"
require "paylane/connection_error"

module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      request(:multiSale, params, 'multi_sale_params')[:multi_sale_response][:response]
    end

    def capture_sale(params)
      request(:captureSale, params)[:capture_sale_response][:response]
    end

    def close_sale_authorization(params)
      request(:closeSaleAuthorization, params)[:close_sale_authorization_response][:response]
    end

    def refund(params)
      request(:refund, params)[:refund_response][:response]
    end

    def resale(params)
      request(:resale, params)[:resale_response][:response]
    end

    def get_sale_result(params)
      request(:getSaleResult, params)[:get_sale_result_response][:response]
    end

    def check_sales(params)
      request(:checkSales, params, 'check_sales_params')[:check_sales_response][:check_sales_response]
    end

    private

    def request(method, params, params_prefix = nil)
      begin
        body = params_prefix ? {params_prefix => params} : params
        soap_response = @client.request(method) { soap.body = body }
        PayLane::Response.new(soap_response.to_hash)
      rescue Savon::Error => e
        err = PayLane::ConnectionError.new(e)
        PayLane.logger.error("[PayLane][Savon] #{err.to_hash}")
        raise err
      end
    end
  end
end

