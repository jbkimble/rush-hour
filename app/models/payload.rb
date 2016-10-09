class Payload < ActiveRecord::Base
  validates :requested_at, :responded_in,
            presence: true

  belongs_to :url
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :event_name
  belongs_to :u_agent
  belongs_to :resolution
  belongs_to :ip

  def self.average_response_time
    Payload.all.reduce(0) {|sum, payload| sum += payload.responded_in }/Payload.all.count
  end

  def self.max_response_time
    Payload.all.max_by {|payload| payload.responded_in}.responded_in
  end

  def self.min_response_time
    Payload.all.min_by {|payload| payload.responded_in}.responded_in
  end
end
