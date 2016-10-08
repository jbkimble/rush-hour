require_relative "../spec_helper"

RSpec.describe "payload" do
  describe "add_payload" do
    it "can add a payload to the database" do
      Payload.create({
                      url_id: 1,
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      user_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })

      expect(Payload.first.responded_in).to eq(37)
    end

    it "can add multiple payloads" do
      Payload.create({
                      url_id: 1,
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      user_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      Payload.create({
                      url_id: 1,
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 40,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      user_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      expect(Payload.first.responded_in).to eq(37)
      expect(Payload.find(2).responded_in).to eq(40)
    end
  end

  describe "payload" do
    it "is invalid without requested_at" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", responded_in: 37, referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end

    it "is invalid without responded_in" do
      payload = Payload.new({url: "http://jumpstartlab.com/blog", requested_at: "2013-02-16 21:38:28 -0700", referred_by: "http://jumpstartlab.com", request_type: "GET", event_name: "socialLogin", user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17", resolution_width: "1920", resolution_height: "1280", ip: "63.29.38.211" })
      expect(payload).to_not be_valid
    end
  end
end
