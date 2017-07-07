class AddParentToTeam < ActiveRecord::Migration[5.1]
  def change
    add_reference :teams, :parent#, foreign_key: true
  end
end
