class RequestType < ActiveRecord::Base
  validates :request_type, presence: true

  has_many :payloads

  def self.most_frequent_request_type
    id = Payload.group(:request_type_id).count.max_by {|key, value| value}.first
    RequestType.find(id).request_type
  end

  def self.all_http_verbs
    RequestType.pluck(:request_type).uniq
  end
end
