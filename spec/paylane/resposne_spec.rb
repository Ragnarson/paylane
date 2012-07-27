require 'spec_helper'

describe PayLane::Response do
  describe '#success?' do
    it "returns true if response has :ok key" do
      response = PayLane::Response.new(ok: {})
      response.success?.should be_true
    end

    it "returns false if resposne hasn't :ok key" do
      response = PayLane::Response.new(error: {})
      response.success?.should be_false
    end
  end
end
