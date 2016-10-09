class ChangeUserAgentTable < ActiveRecord::Migration
  def change
    drop_table :user_agents

    create_table :u_agents do |t|
      t.string :browser
      t.string :operating_system
    end
  end
end
