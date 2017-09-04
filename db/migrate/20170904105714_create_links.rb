class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :goal_id
      t.integer :linked_goal_id

      t.timestamps
    end
  end
end