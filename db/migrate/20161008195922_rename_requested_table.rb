class RenameRequestedTable < ActiveRecord::Migration
  def change
    drop_table :referred_bys

    create_table :referred_bies do |t|
      t.string :referred_by
    end
  end
end
