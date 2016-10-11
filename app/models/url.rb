require "pry"
class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payloads
  has_many :request_types,  through: :payloads
  has_many :referred_bies,  through: :payloads
  has_many :u_agents,       through: :payloads

  def self.list_urls_from_most_least
    grouped = Payload.group(:url_id).count
    sorted = grouped.sort_by{|id, count| count}.reverse
    sorted.map{|(id, count)| Url.find(id).url}
  end

  def max_response_time
    payloads.maximum(:responded_in)
  end

  def min_response_time
    payloads.minimum(:responded_in)
  end

  def all_response_times
    payloads.map {|payload| payload.responded_in}.sort.reverse
  end

  def average_response_time
    payloads.average(:responded_in)
  end

  def list_http_verbs
    request_types.pluck(:request_type).uniq
  end

  def three_most_popular_referrers
    referred_bies.group(:referred_by).count.sort_by {|url, count| count}.reverse
    .map{|url, count| url }[0..2]
  end

  def three_most_popular_user_agents
    u_agents.group(:id).count.sort_by{|id, count| count}.reverse
    .map{|id, count| [UAgent.find(id).browser, UAgent.find(id).operating_system]}[0..2]
  end

  def relative_path
    relative = self.url.split('.com/').last
  end

end
