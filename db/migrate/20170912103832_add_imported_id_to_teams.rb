class AddImportedIdToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :imported_id, :bigint
  end
end
