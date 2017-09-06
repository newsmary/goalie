class AddEndDateToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :end_date, :date
  end
end
