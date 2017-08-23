class AddDescriptionToStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :description, :text
  end
end
