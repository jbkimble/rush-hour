require_relative "../spec_helper"
include DatabaseBuilder

RSpec.describe "When a user visits the events index" do
  it "displays the title including the client identifier" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab/events")

    expect(page).to have_content("Events for Jumpstartlab")
  end

  it "they can click and go to event pages" do
    DatabaseBuilder.build_2
    visit("/sources/jumpstartlab/events")
    click_link("socialLogin")

    expect(current_path).to eq("/sources/jumpstartlab/events/socialLogin")

    visit("/sources/jumpstartlab/events")
    click_link("create")

    expect(current_path).to eq("/sources/jumpstartlab/events/create")
  end

  describe "navbar" do
    it "links to the dashboard" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/events")
      click_link("Dashboard")
      expect(current_path).to eq("/sources/jumpstartlab")
    end

    it "links to the urls" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/events")
      click_link("Urls")
      expect(current_path).to eq("/sources/jumpstartlab/urls")
    end

    it "links to the events" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/events")
      click_link("Events")
      expect(current_path).to eq("/sources/jumpstartlab/events")
    end
  end

end
