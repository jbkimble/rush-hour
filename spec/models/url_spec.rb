require_relative "../spec_helper"

RSpec.describe "url" do
  describe "add_url" do
    it "can add a url to the urls table" do
      Url.create(url: "http://google.com")

      expect(Url.first.url).to eq("http://google.com")
    end

    it "can add multiple urls to the urls table" do
      Url.create(url: "Some_url")
      Url.create(url: "This url")

      expect(Url.first.url).to eq("Some_url")
      expect(Url.last.url).to eq("This url")
    end

  end
end
