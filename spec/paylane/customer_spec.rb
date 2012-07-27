require 'spec_helper'

describe PayLane::Customer do
  let(:customer) { PayLane::Customer }
  let(:api) { PayLane::API }

  describe '.authorize' do
    it 'charges card if customer pay by card' do
      payment_data = {card_number: ""}
      customer.any_instance.should_receive(:charge_card).with(1.00)
      customer.authorize(payment_data)
    end

    it 'charges bank account if customer pay by direct debit' do
      payment_data = {account_number: ""}
      customer.any_instance.should_receive(:direct_debit).with(1.00)
      customer.authorize(payment_data)
    end
  end

  describe 'payment method' do
    let(:params) do
      { 'customer' => {
          'name' => 'John Smith',
          'email' => 'johnsmith@example.com',
          'ip' => '77.237.22.32',
          'address' => {
            'street_house' => '1st Avenue',
            'city' => 'Lodz',
            'state' => 'Lodz',
            'zip' => '00-000',
            'country_code' => 'PL' }},
        'amount' => 10.00,
        'currency_code' => 'EUR',
        'processing_date' => "#{Date.today}",
        'product' => {'description' => "nazwa appki + timestamp" }}
    end

    before do
      PayLane.stub_chain(:logger, :info)
    end

    it 'includes in product description app name and timestamp' do
      pending
    end

    it 'stores details about customer' do
      pending
    end

    describe '#charge_card' do
      let(:customer) do
        PayLane::Customer.new(card_number: 4111111111111111, card_code: 123,
          expiration_month: 12, expiration_year: 2020, name_on_card: 'John Smith')
      end

      it 'charges credit card by specific amount' do
        expected_params = params.merge(
          'payment_method' => {
            'card_data' => {
              'card_number' => 4111111111111111,
              'card_code' => 123,
              'expiration_month' => 12,
              'expiration_year' => 2020,
              'name_on_card' => 'John Smith'
          }})
        api.any_instance.should_receive(:multi_sale).with(expected_params)
        customer.charge_card(10.00)
      end
    end

    describe '#direct_debit' do
      let(:customer) do
        PayLane::Customer.new(account_country: 'DE', bank_code: 12345678,
          account_number: 1234567890, account_holder: 'John Smith')
      end

      it 'charges account by specific amount' do
        expected_params = params.merge(
          'payment_method' => {
            'account_data' => {
              'account_country' => 'DE',
              'bank_code' => 12345678,
              'account_number' => 1234567890,
              'account_holder' => 'John Smith'
          }})
        api.any_instance.should_receive(:multi_sale).with(expected_params)
        customer.direct_debit(10.00)
      end
    end
  end
end
