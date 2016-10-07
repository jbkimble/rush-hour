require_relative "../spec_helper"

RSpec.describe "request" do
  describe "add_request" do
    it "can add a request to the requests table" do
      Request.create(request_type: "GET")

      expect(Request.first.request_type).to eq("GET")
    end

    it "can add multiple requests to the requests table" do
      Request.create(request_type: "GET")
      Request.create(request_type: "POST")

      expect(Request.first.request_type).to eq("GET")
      expect(Request.last.request_type).to eq("POST")
    end
  end

  describe "request" do
    it "is invalid without a request type" do
      request = Request.new()

      expect(request).to_not be_valid
    end
  end
end
