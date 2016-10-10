class AddClientsTable < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :identifier
      t.string :root_url

      t.timestamps null: false
    end

    add_column :payloads, :client_id, :integer
  end
end
