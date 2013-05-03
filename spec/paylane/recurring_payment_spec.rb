require 'spec_helper'

describe PayLane::RecurringPayment do
  let(:api) { PayLane::API }

  before do
    PayLane.stub_chain(:logger, :info)
    PayLane::Product.stub_chain(:new, :description).
      and_return('[2012-11-30 06:30:00 UTC]')
  end

  describe '#charge_card' do
    it 'charges previosuly charged account' do
      payment = PayLane::RecurringPayment.new(1)
      expected_params = {
        'id_sale' => 1,
        'amount' => 20.00,
        'currency' => 'EUR',
        'description' => '[2012-11-30 06:30:00 UTC]'
      }

      api.any_instance.should_receive(:resale).with(expected_params)
      payment.charge_card 20.00
    end
  end
end
