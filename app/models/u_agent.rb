class UAgent < ActiveRecord::Base
  validates :browser, :operating_system, presence: true

  has_many :payloads

  def self.browser_breakdown
    names = UAgent.distinct.pluck(:browser)
    grouped = Hash.new
    names.each do |name|
      u_agent_ids = UAgent.where(browser:[name]).ids
      payloads = Payload.where(u_agent_id:[u_agent_ids])
      grouped[name] = payloads.count
    end
    grouped
  end

  def self.os_breakdown
    names = UAgent.distinct.pluck(:operating_system)
    grouped = Hash.new
    names.each do |name|
      u_agent_ids = UAgent.where(operating_system:[name]).ids
      payloads = Payload.where(u_agent_id:[u_agent_ids])
      grouped[name] = payloads.count
    end
    grouped
  end
end
