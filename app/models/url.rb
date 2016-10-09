require 'pry'
class Url < ActiveRecord::Base
  validates :url, presence: true

  has_many :payloads

  def self.list_urls_from_most_least
    grouped = Url.all.group_by { |url| url.url }
    final = grouped.sort_by { |url, group| group.count }
    final.reduce([]) {|array, group| array << group.first unless array.include?(group.first)}.reverse
  end
end
