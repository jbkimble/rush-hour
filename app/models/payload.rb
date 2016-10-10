class Payload < ActiveRecord::Base
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

end
