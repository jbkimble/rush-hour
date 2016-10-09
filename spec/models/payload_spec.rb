require_relative "../spec_helper"

RSpec.describe "payload" do
  describe "add_payload" do
    it "can add a payload to the database" do
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })

      expect(Payload.first.responded_in).to eq(37)
    end

    it "can add multiple payloads" do
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 40,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      expect(Payload.first.responded_in).to eq(37)
      expect(Payload.find(2).responded_in).to eq(40)
    end
  end

  describe "payload" do
    it "is invalid without requested_at" do
      payload = Payload.new({ responded_in: 37,
                              url_id: 1,
                              referred_by_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end

    it "is invalid without responded_in" do
      payload = Payload.new({ requested_at: "time",
                              url_id: 1,
                              referred_by_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end

    it "is invalid without url_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              referred_by_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end
    it "is invalid without referred_by_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              url_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end
    it "is invalid without request_type_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              url_id: 1,
                              referred_by_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end
    it "is invalid without event_name_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              url_id: 1,
                              referred_by_id: 1,
                              request_type_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end
    it "is invalid without u_agent_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              url_id: 1,
                              referred_by_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              resolution_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end
    it "is invalid without resolution_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              url_id: 1,
                              referred_by_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              ip_id: 1})
      expect(payload).to_not be_valid
    end
    it "is invalid without ip_id" do
      payload = Payload.new({ requested_at: "time",
                              responded_in: 37,
                              url_id: 1,
                              referred_by_id: 1,
                              request_type_id: 1,
                              event_name_id: 1,
                              u_agent_id: 1,
                              resolution_id: 1})
      expect(payload).to_not be_valid
    end
  end

  describe ".average_response_time" do
    it "can calculate average response time" do
      Payload.create({ requested_at: "time",
                    responded_in: 36,
                    url_id: 1,
                    referred_by_id: 1,
                    request_type_id: 1,
                    event_name_id: 1,
                    u_agent_id: 1,
                    resolution_id: 1,
                    ip_id: 1})
      Payload.create({ requested_at: "time",
                    responded_in: 40,
                    url_id: 1,
                    referred_by_id: 1,
                    request_type_id: 1,
                    event_name_id: 1,
                    u_agent_id: 1,
                    resolution_id: 1,
                    ip_id: 1})

      expect(Payload.average_response_time).to eq(38)
    end
  end

  describe ".max_response_time" do
    it "can find the max response time accross all payloads" do
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 36,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 97,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 40,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })

      expect(Payload.max_response_time).to eq(97)
    end
  end

  describe ".min_response_time" do
    it "can find the minimum response time accross all payloads" do
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 36,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 3,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 40,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })

      expect(Payload.min_response_time).to eq(3)
    end
  end
end
