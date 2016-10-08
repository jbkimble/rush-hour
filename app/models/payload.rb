class Payload < ActiveRecord::Base
  validates :requested_at, :responded_in,
            presence: true

  belongs_to :url
  belongs_to :referred_by
  belongs_to :request_type
  belongs_to :event_name
  belongs_to :user_agent
  belongs_to :resolution
  belongs_to :ip
end
