require 'spec_helper'

describe PayLane::Gateway do
  let(:gateway) { PayLane::Gateway.new(PublicTestAccount::LOGIN, PublicTestAccount::PASSWORD) }

  it "authenticate to API" do
    client = gateway.connect
    client.should be_instance_of(Savon::Client)
    client.wsdl.document.should == "https://direct.paylane.com/wsdl/production/Direct.wsdl"
    client.http.auth.basic.should == ["test", "test"]
  end
end

