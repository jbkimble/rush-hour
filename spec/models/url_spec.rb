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

  describe(".max_response_time") do
    it "can find max response time for a specific url" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1})
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

      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 38,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      expect(Url.max_response_time("1")).to eq(38)
    end
  end

  describe(".min_response_time") do
    it "can find min response time for a specific url" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1})
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

      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 38,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      expect(Url.min_response_time("1")).to eq(37)
    end
  end

  describe ".all_response_times" do
    it "returns sorted array from high to low" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1})
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

      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 38,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      expect(Url.all_response_times("1")).to eq([38,37])
    end
  end

  describe ".average_response_time" do
    it "returns average_response_time for url" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1})
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

      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 39,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1
                    })
      expect(Url.average_response_time("1")).to eq(38)
    end
  end

end
