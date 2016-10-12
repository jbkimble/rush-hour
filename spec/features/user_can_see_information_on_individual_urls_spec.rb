require_relative "../spec_helper"
include DatabaseBuilder

RSpec.describe "When a user visits an individual url" do
  it "can see a client header" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab/urls/blog")

    expect(page).to have_content("jumpstartlab")
  end

  it "they can see information for that url" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab/urls/blog")

    within("#url_table") do
      expect(page).to have_content("Max Response Time")
      expect(page).to have_content("Min Response Time")
      expect(page).to have_content("All Response Times")
      expect(page).to have_content("Average Response Time")
      expect(page).to have_content("HTTP Verbs")
      expect(page).to have_content("Three Most Popular User Agents")
      expect(page).to have_content("38")
      expect(page).to have_content("38.0")
      expect(page).to have_content("GET")
      expect(page).to have_content("Chrome: Mac OS X")
    end
  end

  describe "navbar" do
    it "links to the dashboard" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/urls/blog")
      click_link("Dashboard")
      expect(current_path).to eq("/sources/jumpstartlab")
    end

    it "links to the urls" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/urls/blog")
      click_link("Urls")
      expect(current_path).to eq("/sources/jumpstartlab/urls")
    end

    it "links to the events" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/urls/blog")
      click_link("Events")
      expect(current_path).to eq("/sources/jumpstartlab/events")
    end
  end

end
