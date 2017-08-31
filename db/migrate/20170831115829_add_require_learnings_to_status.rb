class AddRequireLearningsToStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :require_learnings, :boolean
  end
end
