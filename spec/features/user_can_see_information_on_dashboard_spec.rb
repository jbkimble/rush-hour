require_relative "../spec_helper"
include DatabaseBuilder

RSpec.describe "When a user visits the dashboard" do
  it "they can see the information" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab")

    within("#identifier") do
      expect(page).to have_content("jumpstartlab")
    end

    within("#my_table") do
        expect(page).to have_content("Average Response Time")
        expect(page).to have_content("Max Response Time")
        expect(page).to have_content("Min Response Time")
        expect(page).to have_content("Most Frequent Request")
        expect(page).to have_content("All HTTP Verbs")
        expect(page).to have_content("Web Browser Breakdown")
        expect(page).to have_content("OS Breakdown")
        expect(page).to have_content("Screen Resolutions")
        expect(page).to have_content("38.0")
        expect(page).to have_content("38")
        expect(page).to have_content("GET")
        expect(page).to have_content("Chrome: 1")
        expect(page).to have_content("Mac OS X: 1")
        expect(page).to have_content("1920x1280")
    end
  end

  describe "navbar" do
    it "links to the dashboard" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab")
      click_link("Dashboard")
      expect(current_path).to eq("/sources/jumpstartlab")
    end

    it "links to the urls" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab")
      click_link("Urls")
      expect(current_path).to eq("/sources/jumpstartlab/urls")
    end

    it "links to the events" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab")
      click_link("Events")
      expect(current_path).to eq("/sources/jumpstartlab/events")
    end
  end
end
