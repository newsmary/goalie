class AddNameToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :name, :string, null: false
  end
end
