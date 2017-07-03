class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :url
      t.text :body

      t.timestamps
    end
  end
end
