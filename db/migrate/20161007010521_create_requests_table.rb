class CreateRequestsTable < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :requestType

      t.timestamps null: false
    end
  end
end
