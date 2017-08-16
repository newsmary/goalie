class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :amount
      t.text :reason
      t.references :user, foreign_key: true
      t.references :goal, foreign_key: true
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
