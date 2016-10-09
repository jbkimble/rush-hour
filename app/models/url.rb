require 'pry'
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

  def self.max_response_time(input_url)
    url_id = Url.where(url: input_url)
    Payload.where(url_id: url_id.ids).maximum(:responded_in)
  end

  def self.min_response_time(input_url)
    url_id = Url.where(url: input_url)
    Payload.where(url_id: url_id.ids).minimum(:responded_in)
  end

  def self.all_response_times(input_url)
    url_id = Url.where(url: input_url)
    Payload.where(url_id: url_id.ids)
    .map {|payload| payload.responded_in}.sort.reverse
  end

  def self.average_response_time(input_url)
    url_id = Url.where(url: input_url)
    Payload.where(url_id: url_id.ids).average(:responded_in)
  end

  def self.list_http_verbs(input_url)
    Url.find_by(url: input_url).request_types.pluck(:request_type).uniq
  end

  def self.three_most_popular_referrers(input_url)
    grouped = Url.find_by(url: input_url).referred_bies.group(:referred_by).count
    grouped.sort_by { |url, count| count}.reverse
    .map{|url, count| url }[0..2]
  end

  def self.three_most_popular_user_agents(input_url)
    u_agents = Url.find_by(url: input_url).u_agents
    grouped = u_agents.group(:id).count
    sorted = grouped.sort_by{|id, count| count}.reverse
    sorted.map{|id, count| [UAgent.find(id).browser, UAgent.find(id).operating_system]}[0..2]
  end

end
