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
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, referred_by_id: 1, request_type_id: 1, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: 1,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
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
                      ip_id: 1,
                      client_id: 1
                    })
      expect(Url.average_response_time("1")).to eq(38)
    end
  end

  describe ".list_http_verbs" do
    it "lists all verbs for URL" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      verb1 = RequestType.create(request_type: "GET")
      verb2 = RequestType.create(request_type: "POST")
      verb3 = RequestType.create(request_type: "PUT")

      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: verb1.id,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1})
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 37,
                      url_id: url2.id,
                      referred_by_id: 1,
                      request_type_id: verb3.id,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 39,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: verb2.id,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
                    })
      Payload.create({
                      requested_at: "2013-02-16 21:38:28 -0700",
                      responded_in: 39,
                      url_id: url1.id,
                      referred_by_id: 1,
                      request_type_id: verb2.id,
                      event_name_id: 1,
                      u_agent_id: 1,
                      resolution_id: 1,
                      ip_id: 1,
                      client_id: 1
                    })

      expect(Url.list_http_verbs("1")).to eq(["GET", "POST"])
    end
  end

  describe ".three_most_popular_referrers" do
    it "can find the three most popular referrers" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      refer1 = ReferredBy.create(referred_by: "google.com")
      refer2 = ReferredBy.create(referred_by: "ham.com")
      refer3 = ReferredBy.create(referred_by: "indapaint.com")
      refer4 = ReferredBy.create(referred_by: "af.com")

      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: refer1.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: refer1.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: refer2.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: refer2.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: refer2.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: refer3.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: refer3.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: refer3.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: refer3.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: refer4.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url2.id, request_type_id: 1, referred_by_id: refer4.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url2.id, request_type_id: 1, referred_by_id: refer4.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url2.id, request_type_id: 1, referred_by_id: refer4.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url2.id, request_type_id: 1, referred_by_id: refer4.id, event_name_id: 1, u_agent_id: 1, resolution_id: 1, ip_id: 1, client_id: 1 })

      expect(Url.three_most_popular_referrers("1")).to eq(["indapaint.com", "ham.com", "google.com"])
    end
  end

  describe ".three_most_popular_user_agents" do
    it "can find the three most popular user agents" do
      url1 = Url.create(url: "1")
      url2 = Url.create(url: "2")
      agent1 = UAgent.create(browser: "Chrome", operating_system: "Linux")
      agent2 = UAgent.create(browser: "Firefox", operating_system: "Unix")
      agent3 = UAgent.create(browser: "Chrome", operating_system: "Windows")
      agent4 = UAgent.create(browser: "Tor", operating_system: "Unix")


      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url: url1, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent: agent4, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent4.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent4.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent4.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent3.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent3.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent3.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent2.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 37, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent2.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url1.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent1.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url2.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent1.id, resolution_id: 1, ip_id: 1, client_id: 1})
      Payload.create({ requested_at: "2013-02-16 21:38:28 -0700", responded_in: 39, url_id: url2.id, request_type_id: 1, referred_by_id: 1, event_name_id: 1, u_agent_id: agent1.id, resolution_id: 1, ip_id: 1, client_id: 1})

      expect(Url.three_most_popular_user_agents("1")).to eq([["Tor", "Unix"], ["Chrome", "Windows"], ["Firefox", "Unix"]])
    end
  end

end
