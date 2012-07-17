require 'spec_helper'

describe PayLane::API do
  before do
    @connection = PayLane::Gateway.new(PublicTestAccount::LOGIN, PublicTestAccount::PASSWORD).connect
    @api = PayLane::API.new(@connection)
  end

  describe '#multi_sale' do
    it "returns id_sale on successful card charge" do
      soap_response = double(
        to_hash: {multi_sale_response: {response: {ok: {id_sale: "2772323"}, data: {fraud_score: "8.76"}}}}
      )
      @connection.should_receive(:request).with(:multiSale).and_return(soap_response)

      params = {
        'payment_method' => {
          'card_data' => {
            'card_number' => 4111111111111111,
            'card_code' => 123,
            'expiration_month' => 12,
            'expiration_year' => 2020,
            'name_on_card' => 'John Smith'
          }
        },
        'customer' => {
          'name' => 'John Smith',
          'email' => 'johnsmith@example.com',
          'ip' => '127.0.0.1',
          'address' => {
            'street_house' => '1st Avenue',
            'city' => 'Lodz',
            'state' => 'Lodz',
            'zip' => '00-000',
            'country_code' => 'PL'
          }
        },
        'amount' => 9.99,
        'currency_code' => "EUR",
        'processing_date' => "#{Date.today}",
        'product' => {
          'description' => "paylane_api_test"
        }
      }

      @api.multi_sale(params).should include({ok: {id_sale: "2772323"}})
    end

    it "returns id_sale on successful direct debit" do
      pending
    end

    it "handle errors" do
      pending
    end
  end

  describe '#get_sale_result' do
    it "returns id_sale if find processed sale" do
      soap_response = double(
        to_hash: {get_sale_result_response: {response: {ok: {id_sale: "2772323"}}}}
      )
      @connection.should_receive(:request).with(:getSaleResult).and_return(soap_response)

      params = {
        'amount' => 9.99,
        'description' => 'paylane_api_test'
      }

      @api.get_sale_result(params).should include({ok: {id_sale: "2772323"}})
    end

    it "returns id_sale_error if find processed sale with error" do
      soap_response = double(
        to_hash: {get_sale_result_response: {response: {ok: {id_sale_error: "831072"}}}}
      )
      @connection.should_receive(:request).with(:getSaleResult).and_return(soap_response)

      params = {
        'amount' => 9.99,
        'description' => 'paylane_api_test'
      }

      @api.get_sale_result(params).should include({ok: {id_sale_error: "831072"}})
    end

    it "handle errors" do
      pending
    end
  end
end

