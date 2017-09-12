class AddImportedIdToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :imported_id, :bigint
  end
end
