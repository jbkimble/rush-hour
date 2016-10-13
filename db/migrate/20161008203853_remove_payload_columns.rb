class RemovePayloadColumns < ActiveRecord::Migration
  def change
    remove_column :payloads, :url
    remove_column :payloads, :referred_by
    remove_column :payloads, :request_type
    remove_column :payloads, :event_name
    remove_column :payloads, :user_agent
    remove_column :payloads, :resolution_width
    remove_column :payloads, :resolution_height
    remove_column :payloads, :ip
  end
end
