class AddConfidenceToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :confidence, :integer
  end
end
