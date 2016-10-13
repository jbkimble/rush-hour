require_relative "../spec_helper"

RSpec.describe "u_agent" do
  describe "add u_agent" do
    it "can add a u_agent to the user_agents table" do
      UAgent.create(browser: "Chrome", operating_system: "Linux")

      expect(UAgent.first.browser).to eq("Chrome")
      expect(UAgent.first.operating_system).to eq("Linux")
    end

    it "can add multiple u_agent to the user_agents table" do
      UAgent.create(browser: "Chrome", operating_system: "Linux")
      UAgent.create(browser: "Chrome", operating_system: "Windows")

      expect(UAgent.first.operating_system).to eq("Linux")
      expect(UAgent.last.operating_system).to eq("Windows")
    end
  end

  describe "u_agent" do
    it "is invalid without a browser" do
      agent = UAgent.new(operating_system: "Linux")

      expect(agent).to_not be_valid
    end

    it "is invalid without a operating_system" do
      agent = UAgent.new(browser: "Chrome")

      expect(agent).to_not be_valid
    end
  end

  describe ".browser_breakdown" do
    it "returns a hash of browsers with count" do
      chrome = UAgent.create(browser: "Chrome", operating_system: "Linux")
      safari = UAgent.create(browser: "Safari", operating_system: "Linux")
      chrome2 = UAgent.create(browser: "Chrome", operating_system: "Windows")
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: 1, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: chrome.id, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: chrome2.id,
                      resolution_id: 1,
                      ip_id: 1, client_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: safari.id,
                      resolution_id: 1,
                      ip_id: 1, client_id: 1
                    })

      expected = {"Chrome" => 2, "Safari" => 1}

      expect(UAgent.browser_breakdown).to eq(expected)
    end
  end

  describe ".os_breakdown" do
    it "returns a hash of operating systems with count" do
      chrome = UAgent.create(browser: "Chrome", operating_system: "Linux")
      safari = UAgent.create(browser: "Safari", operating_system: "Linux")
      chrome2 = UAgent.create(browser: "Chrome", operating_system: "Windows")
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: 1, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: chrome.id, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: chrome2.id,
                      resolution_id: 1,
                      ip_id: 1, client_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: safari.id,
                      resolution_id: 1,
                      ip_id: 1, client_id: 1
                    })

      expected = {"Linux" => 2, "Windows" => 1}

      expect(UAgent.os_breakdown).to eq(expected)
    end
  end
end
