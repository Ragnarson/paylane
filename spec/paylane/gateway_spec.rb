require 'spec_helper'

describe PayLane::Gateway do
  before do
    @gateway = PayLane::Gateway.new(PublicTestAccount::LOGIN, PublicTestAccount::PASSWORD)
  end

  it "authenticate to API" do
    client = @gateway.connect
    client.should be_instance_of(Savon::Client)
    client.wsdl.document.should == "https://direct.paylane.com/wsdl/production/Direct.wsdl"
    client.http.auth.basic.should == ["paylane_test_public", "p2y12n3t3st"]
  end
end

