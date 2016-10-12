require_relative "../spec_helper"
include DatabaseBuilder

RSpec.describe "When a user visits an individual url" do
  it "can see a client header with event name" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab/events/socialLogin")

    expect(page).to have_content("24 Hour Breakdown - socialLogin")
  end

  it "a table shows the breakdown by hour" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab/events/socialLogin")

    within("#events-table") do
      expect(page).to have_content("1")
      expect(page).to have_content("12")
      expect(page).to have_content("24")
    end

    within("#events-table td:nth-child(21)") do
      expect(page).to have_content("1")
    end
    
  end

  describe "navbar" do
    it "links to the dashboard" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/events/socialLogin")
      click_link("Dashboard")
      expect(current_path).to eq("/sources/jumpstartlab")
    end

    it "links to the urls" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/events/socialLogin")
      click_link("Urls")
      expect(current_path).to eq("/sources/jumpstartlab/urls")
    end

    it "links to the events" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/events/socialLogin")
      click_link("Events")
      expect(current_path).to eq("/sources/jumpstartlab/events")
    end
  end

end
