class AddImportedIdToStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :imported_id, :bigint
  end
end
