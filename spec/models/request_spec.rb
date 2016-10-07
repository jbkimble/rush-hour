require_relative "../spec_helper"

RSpec.describe "request" do
  describe "add_request" do
    it "can add a request to the requests table" do
      Request.create(requestType: "GET")

      expect(Request.first.requestType).to eq("GET")
    end

    it "can add multiple requests to the requests table" do
      Request.create(requestType: "GET")
      Request.create(requestType: "POST")

      expect(Request.first.requestType).to eq("GET")
      expect(Request.last.requestType).to eq("POST")
    end
  end

  describe "request" do
    it "is invalid without a request type" do
      request = Request.new()

      expect(request).to_not be_valid
    end
  end
end
