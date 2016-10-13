class EventName < ActiveRecord::Base
  validates :event_name, presence: true

  has_many :payloads

end
