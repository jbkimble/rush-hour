ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.include Capybara::DSL
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:each) do
    DatabaseCleaner.clean
  end
end

module DatabaseBuilder
  def self.build
    json = '{
              "url":"http://jumpstartlab.com/blog",
              "requestedAt":"2013-02-16 21:38:28 -0700",
              "respondedIn":38,
              "referredBy":"http://jumpstartlab.com",
              "requestType":"GET",
              "eventName": "socialLogin",
              "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth":"1920",
              "resolutionHeight":"1280",
              "ip":"63.29.38.211"
            }'
    client = Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    client.populate(json)
  end

  def self.build_2
    json = '{
              "url":"http://jumpstartlab.com/blog",
              "requestedAt":"2013-02-16 21:38:28 -0700",
              "respondedIn":38,
              "referredBy":"http://jumpstartlab.com",
              "requestType":"GET",
              "eventName": "socialLogin",
              "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth":"1920",
              "resolutionHeight":"1280",
              "ip":"63.29.38.211"
            }'
    json2 = '{
              "url":"http://jumpstartlab.com/tutorials",
              "requestedAt":"2013-02-16 21:38:28 -0700",
              "respondedIn":38,
              "referredBy":"http://jumpstartlab.com",
              "requestType":"GET",
              "eventName": "create",
              "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth":"1920",
              "resolutionHeight":"1280",
              "ip":"63.29.38.211"
            }'
    client = Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    client.populate(json)
    client.populate(json2)
  end
end
