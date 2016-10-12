require_relative "../spec_helper"

RSpec.describe "event_name" do
  describe "add_event_name" do
    it "can add an event name to the event name table" do
      EventName.create(event_name: "login")

      expect(EventName.first.event_name).to eq("login")
    end

    it "can add multiple event names to the event name table" do
      EventName.create(event_name: "login")
      EventName.create(event_name: "a action")

      expect(EventName.first.event_name).to eq("login")
      expect(EventName.last.event_name).to eq("a action")
    end
  end

  describe "event validation" do
    it "is invalid without a request type" do
      event = EventName.new()

      expect(event).to_not be_valid
    end
  end

end
