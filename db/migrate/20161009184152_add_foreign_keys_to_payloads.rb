class AddForeignKeysToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :url_id, :integer
    add_column :payloads, :referred_by_id, :integer
    add_column :payloads, :request_type_id, :integer
    add_column :payloads, :event_name_id, :integer
    add_column :payloads, :u_agent_id, :integer
    add_column :payloads, :resolution_id, :integer
    add_column :payloads, :ip_id, :integer
  end
end
