class Payload < ActiveRecord::Base
  validates :url, :requestedAt, :respondedIn, :referredBy, :requestType,
            :eventName, :userAgent, :resolutionWidth, :resolutionHeight, :ip,
            presence: true
end
