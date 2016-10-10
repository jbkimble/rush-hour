require_relative "../spec_helper"

RSpec.describe "resolution" do
  describe "add_resolution" do
    it "can add resolutions to the resolutions table" do
      Resolution.create(resolution_height: "100", resolution_width: "50")

      expect(Resolution.first.resolution_height).to eq("100")
      expect(Resolution.first.resolution_width).to eq("50")
    end

    it "can add multiple resolutions to the resolutions table" do
      Resolution.create(resolution_height: "100", resolution_width: "50")
      Resolution.create(resolution_height: "200", resolution_width: "300")

      expect(Resolution.first.resolution_height).to eq("100")
      expect(Resolution.first.resolution_width).to eq("50")

      expect(Resolution.last.resolution_height).to eq("200")
      expect(Resolution.last.resolution_width).to eq("300")    end
  end

  describe "request" do
    it "is invalid without a resolution type" do
      resolution = Resolution.new()

      expect(resolution).to_not be_valid
    end
  end

  describe ".resolutions_across_payloads" do
    it "can find all the resultion combinations across payloads" do
      resolution1 = Resolution.create(resolution_width:  1, resolution_height: 1)
      resolution2 = Resolution.create(resolution_width:  2, resolution_height: 2)
      resolution3 = Resolution.create(resolution_width:  3, resolution_height: 3)
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: resolution1.id,
                      ip_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: resolution1.id,
                      ip_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: resolution2.id,
                      ip_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: 1,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: resolution3.id,
                      ip_id: 1})
      expected = [["1","1"],["2","2"],["3","3"]]

      expect(Resolution.resolutions_across_payloads).to eq(expected)
    end
  end
end
