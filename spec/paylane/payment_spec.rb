require 'spec_helper'

describe PayLane::Payment do
  let(:api) { PayLane::API }
  let(:adapter) { PayLane::Payment.new }

  describe 'payment method' do
    let(:params) do
      {
        'customer' => {},
        'amount' => 10.00,
        'currency_code' => 'EUR',
        'processing_date' => "#{Date.today}",
        'product' => {
          'description' => '[][2012-11-30 06:30:00 UTC]'
        }
      }
    end

    before do
      PayLane.stub_chain(:logger, :info)
      Time.stub_chain(:now, :getutc).and_return(Time.utc(2012, 11, 30, 6, 30))
    end

    describe '#charge_card' do
      it 'charges credit card by specific amount' do
        expected_params = params.merge('payment_method' => {'card_data' => {}})
        api.any_instance.should_receive(:multi_sale).with(expected_params)
        adapter.charge_card(10.00)
      end
    end

    describe '#direct_debit' do
      it 'charges account by specific amount' do
        expected_params = params.merge('payment_method' => {'account_data' => {}})
        api.any_instance.should_receive(:multi_sale).with(expected_params)
        adapter.direct_debit(10.00)
      end
    end
  end
end
