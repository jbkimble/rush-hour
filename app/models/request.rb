class Request < ActiveRecord::Base
  validates :requestType, presence: true
end
