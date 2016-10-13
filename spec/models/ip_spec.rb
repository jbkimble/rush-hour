require_relative "../spec_helper"

RSpec.describe "ip" do
  describe "add ip" do
    it "can add an ip to the ip table" do
      Ip.create(ip: "999999")

      expect(Ip.first.ip).to eq("999999")
    end

    it "can add multiple ips to the ip table" do
      Ip.create(ip: "888888")
      Ip.create(ip: "777777")

      expect(Ip.first.ip).to eq("888888")
      expect(Ip.last.ip).to eq("777777")
    end
  end

  describe "ip validation" do
    it "is invalid without a request type" do
      ip = Ip.new()

      expect(ip).to_not be_valid
    end
  end
end
