require "paylane/response"
require "paylane/connection_error"

module PayLane
  class API
    def initialize(client)
      @client = client
    end

    def multi_sale(params)
      response = request(:multiSale, params, 'multi_sale_params')
      Response.new(response[:multi_sale_response][:response])
    end

    def capture_sale(params)
      response = request(:captureSale, params)
      Response.new(response[:capture_sale_response][:response])
    end

    def close_sale_authorization(params)
      response = request(:closeSaleAuthorization, params)
      Response.new(response[:close_sale_authorization_response][:response])
    end

    def refund(params)
      response = request(:refund, params)
      Response.new(response[:refund_response][:response])
    end

    def resale(params)
      response = request(:resale, params)
      Response.new(response[:resale_response][:response])
    end

    def get_sale_result(params)
      response = request(:getSaleResult, params)
      Response.new(response[:get_sale_result_response][:response])
    end

    def check_sales(params)
      response = request(:checkSales, params, 'check_sales_params')
      Response.new(response[:check_sales_response][:check_sales_response])
    end

    private

    def request(method, params, params_prefix = nil)
      begin
        @client.request(method) do
          soap.body = (params_prefix ? {params_prefix => params} : params)
        end.to_hash
      rescue Savon::Error => e
        err = ConnectionError.new(e)
        PayLane.logger.error("[PayLane][Savon] #{err.to_hash}")
        raise err
      end
    end
  end
end

