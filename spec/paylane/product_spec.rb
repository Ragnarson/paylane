require 'spec_helper'

describe PayLane::Product do
  before do
    Time.stub_chain(:now, :getutc).and_return(Time.utc(2012, 11, 30, 6, 30))
  end

  describe '#description' do
    it 'handles product description' do
      product = PayLane::Product.new 'tank'
      product.description.should == '[tank][2012-11-30 06:30:00 UTC]'

      product = PayLane::Product.new %w(black tank)
      product.description.should == '[black][tank][2012-11-30 06:30:00 UTC]'
    end
  end
end

