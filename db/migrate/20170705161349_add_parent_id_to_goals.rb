class AddParentIdToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :parent_id, :integer
  end
end
