require 'pry'
class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payloads

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
end
