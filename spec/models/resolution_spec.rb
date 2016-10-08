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
end
