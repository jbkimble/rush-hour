class Resolution < ActiveRecord::Base
  validates :resolution_width, :resolution_height, presence: true

  has_many :payloads

  def self.resolutions_across_payloads
    Resolution.pluck(:resolution_height, :resolution_width).uniq
  end
end
