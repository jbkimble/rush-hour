class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payloads
end
