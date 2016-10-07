require_relative "../spec_helper"

RSpec.describe "payload" do
  describe "add_payload" do
    it "can add a payload to the database" do
      Payload.create({
                      url: "http://jumpstartlab.com/blog",
                      requestedAt: "2013-02-16 21:38:28 -0700",
                      respondedIn: 37,
                      referredBy: "http://jumpstartlab.com",
                      requestType: "GET",
                      eventName: "socialLogin",
                      userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolutionWidth: "1920",
                      resolutionHeight: "1280",
                      ip: "63.29.38.211"
                    })

      expect(Payload.first.ip).to eq("63.29.38.211")
    end

    it "can add multiple payloads" do
      Payload.create({
                      url: "http://jumpstartlab.com/blog",
                      requestedAt: "2013-02-16 21:38:28 -0700",
                      respondedIn: 37,
                      referredBy: "http://jumpstartlab.com",
                      requestType: "GET",
                      eventName: "socialLogin",
                      userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolutionWidth: "1920",
                      resolutionHeight: "1280",
                      ip: "3"
                    })
      Payload.create({
                      url: "http://jumpstartlab.com/blog",
                      requestedAt: "2013-02-16 21:38:28 -0700",
                      respondedIn: 37,
                      referredBy: "http://jumpstartlab.com",
                      requestType: "GET",
                      eventName: "socialLogin",
                      userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                      resolutionWidth: "1920",
                      resolutionHeight: "1280",
                      ip: "7"
                    })
      expect(Payload.first.ip).to eq("3")
      expect(Payload.find(2).ip).to eq("7")
    end
  end

  describe "payload" do
    it "is invalid without url" do
      payload = Payload.new({requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without requestedAt" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without respondedIn" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without referredBy" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without requestType" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without eventName" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without userAgent" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", resolutionWidth: "1920", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without resolutionWidth" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionHeight: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without resolutionHeight" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without ip" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requestedAt: "2013-02-16 21:38:28 -0700", respondedIn: 37, referredBy: "http://jumpstartlab.com", requestType: "GET", eventName: "socialLogin", userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolutionWidth: "1920", resolutionHeight: "1280"})
      expect(payload).to_not be_valid
    end

  end
end
