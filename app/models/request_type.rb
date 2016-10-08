require 'pry'

class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payloads

  def self.most_frequent_request_type
    grouped = RequestType.all.group_by { |request| request.request_type }
    grouped.max_by { |type, group| group.count }.first
  end

  def self.all_http_verbs
    RequestType.all.reduce([]) { |array, req| array << req.request_type unless
      array.include?(req.request_type) }
  end
end
