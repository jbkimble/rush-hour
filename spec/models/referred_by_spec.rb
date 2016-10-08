require_relative "../spec_helper"

RSpec.describe "referred_by" do
  describe "add_referred_by" do
    it "can add a referred_by to the referred_bys table" do
      ReferredBy.create(referred_by: "some referral")

      expect(ReferredBy.first.referred_by).to eq("some referral")
    end

    it "can add multiple referred_bys to the referred_bys table" do
      ReferredBy.create(referred_by: "some referral")
      ReferredBy.create(referred_by: "some other referral")

      expect(ReferredBy.first.referred_by).to eq("some referral")
      expect(ReferredBy.last.referred_by).to eq("some other referral")
    end
  end

  describe "referred_by" do
    it "is invalid without referred_by" do
      referred_by = ReferredBy.new()

      expect(referred_by).to_not be_valid
    end
  end
end
