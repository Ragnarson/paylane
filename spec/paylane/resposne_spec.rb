require 'spec_helper'

describe PayLane::Response do
  let(:ok_response) { PayLane::Response.new(ok: {}) }
  let(:error_response) { PayLane::Response.new(error: {error_description: 'Something went wrong'}) }

  describe '#success?' do
    it "returns true if response has :ok key" do
      ok_response.has_ok?.should be_true
    end

    it "returns false if resposne hasn't :ok key" do
      error_response.has_ok?.should be_false
    end
  end

  describe '#error?' do
    it "returns true if response has :error key" do
      error_response.has_error?.should be_true
    end

    it "returns false if resposne hasn't :error key" do
      ok_response.has_error?.should be_false
    end
  end

  describe '#error_description' do
    it 'returns error description' do
      error_response.error_description.should == 'Something went wrong'
    end
  end
end
