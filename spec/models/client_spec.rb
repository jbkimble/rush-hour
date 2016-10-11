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
      expect(UAgent.first.operating_system).to eq("Mac OS X")
      expect(Resolution.first.resolution_width).to eq("1920")
      expect(Ip.first.ip).to eq("63.29.38.211")
      expect(Payload.first.responded_in).to eq(37)
    end

    it "populates multiple objects" do
      json = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":38,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
      json2 = '{
                "url":"2",
                "requestedAt":"2",
                "respondedIn":2,
                "referredBy":"2",
                "requestType":"2",
                "eventName": "2",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"2",
                "resolutionHeight":"2",
                "ip":"2"
              }'
      client = Client.create(identifier: "test1", root_url: "hamAF.com")
      client.populate(json)
      client.populate(json2)

      expect(Url.second.url).to eq("2")
      expect(ReferredBy.second.referred_by).to eq("2")
      expect(RequestType.second.request_type).to eq("2")
      expect(EventName.second.event_name).to eq("2")
      expect(UAgent.first.operating_system).to eq("Mac OS X")
      expect(Resolution.second.resolution_width).to eq("2")
      expect(Ip.second.ip).to eq("2")
      expect(Payload.second.responded_in).to eq(2)
    end
  end
  describe "test of scope of class vs instance methods" do
    it "uses average response time of only its payloads" do
      json = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":38,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
      json2 = '{
                "url":"2",
                "requestedAt":"2",
                "respondedIn":2,
                "referredBy":"2",
                "requestType":"2",
                "eventName": "2",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"2",
                "resolutionHeight":"2",
                "ip":"2"
              }'
      client = Client.create(identifier: "test1", root_url: "hamAF.com")
      client2 = Client.create(identifier: "test2", root_url: "ebaumsworld.com")

      client.populate(json)
      client2.populate(json2)

      expect(client.payloads.average_response_time).to eq(38)
      expect(client2.payloads.average_response_time).to eq(2)
      expect(client.payloads.average(:responded_in)).to eq(38)
      expect(client2.payloads.average(:responded_in)).to eq(2)

    end
  end

end
