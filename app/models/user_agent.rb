class UAgent < ActiveRecord::Base
  validates :browser, :operating_system, presence: true

  has_many :payloads
end
