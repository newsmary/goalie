class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :favorable
      t.string :favorable_type

      t.timestamps

    end

    add_index :favorites, [:user_id, :favorable_id, :favorable_type], unique: true

  end
end
