require_relative "../spec_helper"

RSpec.describe "request_type" do
  describe "add_request" do
    it "can add a request to the requests table" do
      RequestType.create(request_type: "GET")

      expect(RequestType.first.request_type).to eq("GET")
    end

    it "can add multiple requests to the requests table" do
      RequestType.create(request_type: "GET")
      RequestType.create(request_type: "POST")

      expect(RequestType.first.request_type).to eq("GET")
      expect(RequestType.last.request_type).to eq("POST")
    end
  end

  describe "request" do
    it "is invalid without a request type" do
      request = RequestType.new()

      expect(request).to_not be_valid
    end
  end
end
