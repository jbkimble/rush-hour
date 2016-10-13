class AddTablesForUrlReferedByEventNameUserAgentResHeightAndWidthAndIp < ActiveRecord::Migration
  def change
    drop_table :requests

    create_table :referred_bys do |t|
      t.string :referred_by
    end

    create_table :urls do |t|
      t.string :url
    end

    create_table :event_names do |t|
      t.string :event_name
    end

    create_table :user_agents do |t|
      t.string :user_agent
    end

    create_table :resolutions do |t|
      t.string :resolution_height
      t.string :resolution_width
    end

    create_table :ips do |t|
      t.string :ip
    end

    create_table :request_types do |t|
      t.string :request_type
    end
  end

end
