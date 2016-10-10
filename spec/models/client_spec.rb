require_relative "../spec_helper"

RSpec.describe "client" do
  describe "add_client" do
    it "can add a client to the clients table" do
      Client.create(identifier: "this", root_url: "a")

      expect(Client.all.first.identifier).to eq("this")
    end
  end

  describe "validates" do
    it "is invalid without identifier" do
      client = Client.new(root_url: "a")

      expect(client).to_not be_valid
    end

    it "is invalid without root_url" do
      client = Client.new(identifier: "a")

      expect(client).to_not be_valid
    end
  end
end
