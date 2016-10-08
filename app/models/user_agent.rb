class UserAgent < ActiveRecord::Base
  validates :user_agent, presence: true

  has_many :payloads
end
