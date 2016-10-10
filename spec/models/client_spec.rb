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

  describe ".populate" do
    it "populates all objects" do
      json = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'

      client = Client.create(identifier: "test1", root_url: "hamAF.com")
      client.populate(json)

      expect(Url.first.url).to eq("http://jumpstartlab.com/blog")
      expect(ReferredBy.first.referred_by).to eq("http://jumpstartlab.com")
      expect(RequestType.first.request_type).to eq("GET")
      expect(EventName.first.event_name).to eq("socialLogin")
      expect(UAgent.first.operating_system).to eq("Macintosh")
      expect(Resolution.first.resolution_width).to eq("1920")
      expect(Ip.first.ip).to eq("63.29.38.211")
      expect(Payload.first.responded_in).to eq(37)
    end
  end
end
