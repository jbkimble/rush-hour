class ReferredBy < ActiveRecord::Base
  validates :referred_by, presence: true

  has_many :payloads
end
