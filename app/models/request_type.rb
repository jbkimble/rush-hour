class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payloads
end
