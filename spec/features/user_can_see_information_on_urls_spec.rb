require_relative "../spec_helper"
include DatabaseBuilder

RSpec.describe "When a user visits the urls index" do
  it "displays the title including the client identifier" do
    DatabaseBuilder.build
    visit("/sources/jumpstartlab/urls")

    expect(page).to have_content("All Urls for Jumpstartlab")
  end

  it "they can click and go to link pages" do
    DatabaseBuilder.build_2
    visit("/sources/jumpstartlab/urls")
    click_link("http://jumpstartlab.com/blog")

    expect(current_path).to eq("/sources/jumpstartlab/urls/blog")

    visit("/sources/jumpstartlab/urls")
    click_link("http://jumpstartlab.com/tutorials")

    expect(current_path).to eq("/sources/jumpstartlab/urls/tutorials")
  end

  describe "navbar" do
    it "links to the dashboard" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/urls")
      click_link("Dashboard")
      expect(current_path).to eq("/sources/jumpstartlab")
    end

    it "links to the urls" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/urls")
      click_link("Urls")
      expect(current_path).to eq("/sources/jumpstartlab/urls")
    end

    it "links to the events" do
      DatabaseBuilder.build
      visit("/sources/jumpstartlab/urls")
      click_link("Events")
      expect(current_path).to eq("/sources/jumpstartlab/events")
    end
  end

end
