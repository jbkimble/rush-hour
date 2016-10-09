require 'pry'
class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payloads

  def self.list_urls_from_most_least
    grouped = Payload.group(:url_id).count
    sorted = grouped.sort_by{|id, count| count}.reverse
    sorted.map{|(id, count)| Url.find(id).url}
  end
end
