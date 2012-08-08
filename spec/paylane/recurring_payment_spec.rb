require 'spec_helper'

describe PayLane::RecurringPayment do
  let(:api) { PayLane::API }
  let(:recurring_payment) { PayLane::RecurringPayment.new(12345) }

  before do
    PayLane.stub_chain(:logger, :info)
    Time.stub_chain(:now, :getutc).and_return(Time.utc(2012, 11, 30, 6, 30))
  end

  describe '#charge_card' do
    it 'charges previosuly charged account' do
      expected_params = {
        'id_sale' => 12345,
        'amount' => 20.00,
        'currency' => 'EUR',
        'description' => '[][2012-11-30 06:30:00 UTC]'
      }
      api.any_instance.should_receive(:resale).with(expected_params)
      recurring_payment.charge_card(20.00)
    end
  end
end
