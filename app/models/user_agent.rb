require 'pry'
class UAgent < ActiveRecord::Base
  validates :browser, :operating_system, presence: true

  has_many :payloads

  def self.browser_breakdown
    # grouped = Payload.all.group_by{|payload| payload.u_agent_id}
    binding.pry
  end
end
