require 'spec_helper'

describe PayLane::Configuration do
  it 'stores default configuration' do
    PayLane::Configuration.currency.should == "EUR"
    PayLane::Configuration.login.should == "paylane_test_public"
    PayLane::Configuration.password.should == "p2y12n3t3st"
  end
end
