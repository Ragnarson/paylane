require 'spec_helper'

describe PayLane::Response do
  context 'has :ok and :data hashes' do
    let(:response) do
      PayLane::Response.new { {ok: {sale_id: 1}, data: {fraud_score: 1.0}} }
    end

    it "returns true on #has_ok?" do
      response.has_ok?.should be_true
    end

    it "returns false on #has_error?" do
      response.has_error?.should be_false
    end

    it "returns content of :ok key on #attributes" do
      response.attributes.should == {sale_id: 1, fraud_score: 1.00}
    end

    it "returns true on #has_data?" do
      response.has_data?.should be_true
    end
  end

  context 'has :error hash' do
    let(:response) do
      PayLane::Response.new { {error: {error_description: 'Something went wrong'}} }
    end

    it "returns false on #has_ok?" do
      response.has_ok?.should be_false
    end

    it "returns true on #has_error?" do
      response.has_error?.should be_true
    end

    it "returns error description" do
      response.error_description.should == 'Something went wrong'
    end

    it "returns content of :error key on #attributes" do
      response.attributes.should == {error_description: 'Something went wrong'}
    end

    it "returns false on #has_data?" do
      response.has_data?.should be_false
    end
  end
end
