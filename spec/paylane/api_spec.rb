require 'spec_helper'

describe PayLane::API do
  let(:connection) {
    gateway = PayLane::Gateway.new(PublicTestAccount::LOGIN, PublicTestAccount::PASSWORD)
    gateway.connect
  }
  let(:api) { PayLane::API.new(connection) }

  describe '#multi_sale' do
    let(:params) do
      params = {
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
        'product' => {
          'description' => "paylane_api_test"
      }}
    end

    it "returns id_sale on successful card charge" do
      mock_api_method(connection, :multiSale) do
        {multi_sale_response: {response: {ok: {id_sale: "2772323"}, data: {fraud_score: "8.76"}}}}
      end

      params.merge({
        'payment_method' => {
          'card_data' => {
            'card_number' => 4111111111111111,
            'card_code' => 123,
            'expiration_month' => 12,
            'expiration_year' => 2020,
            'name_on_card' => 'John Smith'
      }}})

      api.multi_sale(params).should include({ok: {id_sale: "2772323"}})
    end

    it "returns id_sale on successful direct debit" do
      mock_api_method(connection, :multiSale) do
        {multi_sale_response: {response: {ok: {id_sale: "2772323"}, data: {fraud_score: "8.76"}}}}
      end

      params.merge({
        'payment_method' => {
          'card_data' => {
            'account_country' => 'DE',
            'bank_code' => 12345678,
            'account_number' => 12345678901,
            'account_holder' => 'John Smith'
      }}})

      api.multi_sale(params).should include({ok: {id_sale: "2772323"}})
    end

    it "returns id_sale_authorization for sales marked by 'capture_later'" do
      mock_api_method(connection, :multiSale) do
        {multi_sale_response: {response: {ok: {id_sale_authorization: "2772323"}, data: {fraud_score: "8.76"}}}}
      end

      params.merge({
        'payment_method' => {
          'card_data' => {
            'card_number' => 4111111111111111,
            'card_code' => 123,
            'expiration_month' => 12,
            'expiration_year' => 2020,
            'name_on_card' => 'John Smith'
          }
        },
        'capture_later' => true
      })

      api.multi_sale(params).should include({ok: {id_sale_authorization: "2772323"}})
    end
  end

  describe '#capture_sale' do
    it "returns id_sale on successful sale authorization" do
      mock_api_method(connection, :captureSale) do
        {capture_sale_response: {response: {ok: {id_sale: "2772323"}}}}
      end

      params = {
        'id_sale_authorization' => '119225',
        'amount' => 9.99
      }

      api.capture_sale(params).should include({ok: {id_sale: "2772323"}})
    end
  end

  describe 'close_sale_authorization' do
    it "returns id_closed on successful close sale authorization" do
      mock_api_method(connection, :closeSaleAuthorization) do
        {close_sale_authorization_response: {response: {ok: {is_closed: true}}}}
      end

      params = {'id_sale_authorization' => '119225'}

      api.close_sale_authorization(params).should include({ok: {is_closed: true}})
    end
  end

  describe '#refund' do
    it 'returns id_refund on successful refund' do
      mock_api_method(connection, :refund) do
        {refund_response: {response: {ok: {id_refund: "213871"}}}}
      end

      params = {
        'id_sale' => '2772323',
        'amount' => 9.99,
        'reason' => 'test_refund_method'
      }

      api.refund(params).should include({ok: {id_refund: "213871"}})
    end
  end

  describe '#resale' do
    it 'returns id_sale on successful performed recurring charge' do
      mock_api_method(connection, :resale) do
        {resale_response: {response: {ok: {id_sale: "2773239"}}}}
      end

      params = {
        'id_sale' => '2772323',
        'amount' => 20.00,
        'currency' => 'EUR',
        'description' => 'paylane_api_test_resale'
      }

      api.resale(params).should include({ok: {id_sale: "2773239"}})
    end
  end

  describe '#get_sale_result' do
    it "returns id_sale if find processed sale" do
      mock_api_method(connection, :getSaleResult) do
        {get_sale_result_response: {response: {ok: {id_sale: "2772323"}}}}
      end

      params = {
        'amount' => 9.99,
        'description' => 'paylane_api_test'
      }

      api.get_sale_result(params).should include({ok: {id_sale: "2772323"}})
    end

    it "returns id_sale_error if find processed sale with error" do
      mock_api_method(connection, :getSaleResult) do
        {get_sale_result_response: {response: {ok: {id_sale_error: "831072"}}}}
      end

      params = {
        'amount' => 9.99,
        'description' => 'paylane_api_test'
      }

      api.get_sale_result(params).should include({ok: {id_sale_error: "831072"}})
    end
  end

  describe '#check_sales' do
    it 'returns details for requested sale ids' do
      mock_api_method(connection, :checkSales) do
        {check_sales_response: {check_sales_response: {ok: {sale_status: [{id_sale: "1", status: "NOT_FOUND", is_refund: false, is_chargeback: false, is_reversal: false}, {id_sale: "2772323", status: "PERFORMED", is_refund: false, is_chargeback: false, is_reversal: false}]}}}}
      end

      params = {'id_sale_list' => [2772323, 1]}

      sales = api.check_sales(params)[:ok][:sale_status]
      sales.should include({id_sale: "1", status: "NOT_FOUND", is_refund: false, is_chargeback: false, is_reversal: false})
      sales.should include({id_sale: "2772323", status: "PERFORMED", is_refund: false, is_chargeback: false, is_reversal: false})
    end
  end

  describe 'handle savon error' do
    let(:savon_http_error) {
      Savon::HTTP::Error.new(double(error?: true, code: 404, body: 'Not Found'))
    }

    it 'logs and raise PayLane::ConnectionError' do
      connection.stub(:request).and_raise(savon_http_error)
      PayLane.logger.should_receive(:error).with("[PayLane][Savon] HTTP error (404): Not Found")
      expect {
        api.multi_sale({})
      }.to raise_error(PayLane::ConnectionError)
    end
  end
end

