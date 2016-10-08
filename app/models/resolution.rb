class Resolution < ActiveRecord::Base
  validates :resolution, presence: true

  has_many :payloads
end
