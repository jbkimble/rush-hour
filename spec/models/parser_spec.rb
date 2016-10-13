require_relative '../spec_helper'

include Parser

RSpec.describe "parser" do
  describe ".parse_payload" do
    it "can turn json data into expected payload" do
      json = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'

        expected = {url: "http://jumpstartlab.com/blog",
            requested_at: "2013-02-16 21:38:28 -0700",
            responded_in: 37,
            referred_by: "http://jumpstartlab.com",
            request_type: "GET",
            event_name: "socialLogin",
            user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
            resolution_width: "1920",
            resolution_height: "1280",
            ip: "63.29.38.211"
            }

      expect(Parser.parse_payload(json)).to eq(expected)
    end
  end
end
