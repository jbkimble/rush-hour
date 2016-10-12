require_relative "../spec_helper"
include DatabaseBuilder

RSpec.describe "When a user visits '/'" do
  it "they can login to their dashboard" do
    DatabaseBuilder.build
    visit("/")
    fill_in("user", with: "jumpstartlab")
    click_button("Submit")
    expect(current_path).to eq("/sources/jumpstartlab")
  end
end
