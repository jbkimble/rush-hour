class Resolution < ActiveRecord::Base
  validates :resolution_width, :resolution_height, presence: true

  has_many :payloads
end
