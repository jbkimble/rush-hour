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

  describe ".list_urls_from_most_least" do
    it "can list urls from most used to least used" do
      url1 = Url.create(url: "Some_url")
      url2 = Url.create(url: "This url")
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1 })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })

      expect(Url.list_urls_from_most_least).to eq(["Some_url", "This url"])
    end
  end

end
