class Request < ActiveRecord::Base
  validates :request_type, presence: true
end
