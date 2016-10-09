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
    it "returns 2d array of browsers with count" do
      UAgent.create(browser: "Chrome", operating_system: "Linux")
      UAgent.create(browser: "Safari", operating_system: "Linux")
      Payload.create(requested_at: "stuff", responded_in: 3)
      Payload.create(requested_at: "stuff", responded_in: 3)
      Payload.create(requested_at: "stuff", responded_in: 3)
      expected = {"Chrome" => 2, "Safari" => 1}

      expect(UAgent.browser_breakdown).to eq(expected)
    end
  end
end
