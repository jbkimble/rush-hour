require './app/models/parser'
require 'user_agent_parser'

class Payload < ActiveRecord::Base
  include Parser

  validates :requested_at, :responded_in, :url_id, :referred_by_id,
  :request_type_id, :event_name_id, :u_agent_id, :resolution_id, :ip_id,
  :client_id, presence: true

  belongs_to :url
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :event_name
  belongs_to :u_agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client

  def self.average_response_time
    Payload.average(:responded_in)
  end

  def self.max_response_time
    Payload.maximum(:responded_in)
  end

  def self.min_response_time
    Payload.minimum(:responded_in)
  end

  def self.already_exists?(params)
        parsed_payload =  Parser.parse_payload(params[:payload])
        agent = UserAgentParser.parse(parsed_payload[:user_agent])


        url = Url.find_by(url: parsed_payload[:url])
        referred_by = ReferredBy.find_by(referred_by: parsed_payload[:referred_by])
        request_type = RequestType.find_by(request_type: parsed_payload[:request_type])
        event_name = EventName.find_by(event_name: parsed_payload[:event_name])
        u_agent = UAgent.find_by(browser: agent.family, operating_system: agent.os.family)
        resolution = Resolution.find_by(resolution_width: parsed_payload[:resolution_width], resolution_height: parsed_payload[:resolution_height])
        ip = Ip.find_by(ip: parsed_payload[:ip])
        payload = Payload.find_by(requested_at: parsed_payload[:requested_at], responded_in: parsed_payload[:responded_in].to_i, url: url,
                        referred_by: referred_by, request_type: request_type, event_name: event_name, u_agent: u_agent,
                        resolution: resolution, ip: ip)
  end

end
