class Payload < ActiveRecord::Base
  validates :url, :requested_at, :responded_in, :referred_by, :request_type,
            :event_name, :user_agent, :resolution_width, :resolution_height, :ip,
            presence: true
end
