require_relative "../spec_helper"

RSpec.describe "payload" do
  describe "add_payload" do
    it "can add a payload to the database" do
      Payload.create({
                      url: "http://jumpstartlab.com/blog",
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      referred_by: "http://jumpstartlab.com",
                      request_type: "GET",
                      event_name: "socialLogin",
                      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolution_width: "1920",
                      resolution_height: "1280",
                      ip: "63.29.38.211"
                    })

      expect(Payload.first.ip).to eq("63.29.38.211")
    end

    it "can add multiple payloads" do
      Payload.create({
                      url: "http://jumpstartlab.com/blog",
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      referred_by: "http://jumpstartlab.com",
                      request_type: "GET",
                      event_name: "socialLogin",
                      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolution_width: "1920",
                      resolution_height: "1280",
                      ip: "3"
                    })
      Payload.create({
                      url: "http://jumpstartlab.com/blog",
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      referred_by: "http://jumpstartlab.com",
                      request_type: "GET",
                      event_name: "socialLogin",
                      user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolution_width: "1920",
                      resolution_height: "1280",
                      ip: "7"
                    })
      expect(Payload.first.ip).to eq("3")
      expect(Payload.find(2).ip).to eq("7")
    end
  end

  describe "payload" do
    it "is invalid without url" do
      payload = Payload.new({requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without requested_at" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without responded_in" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without referred_by" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without request_type" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without event_name" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without user_agent" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without resolution_width" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without resolution_height" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without ip" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280"})
      expect(payload).to_not be_valid
    end

  end
end
