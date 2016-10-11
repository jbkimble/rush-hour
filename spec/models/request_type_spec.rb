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

  describe ".most_frequent_request_type" do
    it "can find most frequent request type" do
      get = RequestType.create(request_type: "GET")
      post = RequestType.create(request_type: "POST")
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: 1, referred_by_id: 1, request_type_id: get.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: 1, referred_by_id: 1, request_type_id: post.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: get.id,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 2
                    })

      expect(RequestType.most_frequent_request_type).to eq("GET")
    end
  end

  describe "request" do
    it "is invalid without a request type" do
      request = RequestType.new()

      expect(request).to_not be_valid
    end
  end


  describe ".all_http_verbs" do
    it "can list all http verbs used" do
      RequestType.create(request_type: "GET")
      RequestType.create(request_type: "POST")

      expect(RequestType.all_http_verbs).to eq(["GET", "POST"])
    end
  end
end
