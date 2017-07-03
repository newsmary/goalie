class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.text :body
      t.string :quarter
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
