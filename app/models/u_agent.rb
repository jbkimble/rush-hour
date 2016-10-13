class UAgent < ActiveRecord::Base
  validates :browser, :operating_system, presence: true

  has_many :payloads

  def self.browser_breakdown
    UAgent.group(:browser).count
  end

  def self.os_breakdown
    UAgent.group(:operating_system).count
  end
end
