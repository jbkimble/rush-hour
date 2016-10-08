require_relative "../spec_helper"

RSpec.describe "user_agent" do
  describe "add user_agent" do
    it "can add a user_agent to the user_agents table" do
      UserAgent.create(user_agent: "GET")

      expect(UserAgent.first.user_agent).to eq("GET")
    end

    it "can add multiple user_agent to the user_agents table" do
      UserAgent.create(user_agent: "GET")
      UserAgent.create(user_agent: "POST")

      expect(UserAgent.first.user_agent).to eq("GET")
      expect(UserAgent.last.user_agent).to eq("POST")
    end
  end

  describe "request" do
    it "is invalid without a user_agents type" do
      request = UserAgent.new()

      expect(request).to_not be_valid
    end
  end
end
