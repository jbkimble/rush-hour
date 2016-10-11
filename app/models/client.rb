require 'pry'
require './app/models/parser'
require 'user_agent_parser'

class Client < ActiveRecord::Base
  include Parser

  validates :identifier, :root_url, presence: true

  has_many :payloads
  has_many :referred_bies,  through: :payloads
  has_many :request_types,  through: :payloads
  has_many :event_names,    through: :payloads
  has_many :u_agents,       through: :payloads
  has_many :resolutions,    through: :payloads
  has_many :ips,            through: :payloads
  has_many :urls,           through: :payloads

  def populate(payload)
    parsed_payload = Parser.parse_payload(payload)
    agent = UserAgentParser.parse(parsed_payload[:user_agent])

    url = Url.find_or_create_by(url: parsed_payload[:url])
    referred_by = ReferredBy.find_or_create_by(referred_by: parsed_payload[:referred_by])
    request_type = RequestType.find_or_create_by(request_type: parsed_payload[:request_type])
    event_name = EventName.find_or_create_by(event_name: parsed_payload[:event_name])
    u_agent = UAgent.find_or_create_by(browser: agent.family, operating_system: agent.os.family)
    resolution = Resolution.find_or_create_by(resolution_width: parsed_payload[:resolution_width], resolution_height: parsed_payload[:resolution_height])
    ip = Ip.find_or_create_by(ip: parsed_payload[:ip])

    Payload.find_or_create_by(requested_at: parsed_payload[:requested_at], responded_in: parsed_payload[:responded_in].to_i, url: url,
                    referred_by: referred_by, request_type: request_type, event_name: event_name, u_agent: u_agent,
                    resolution: resolution, ip: ip, client: self)
  end
end
