class Person < ApplicationRecord
  #use our existing users table (managed by devise)
  self.table_name= :users
  default_scope { order(:name) }
  validates :email, uniqueness: true
  has_many :goals, foreign_key: "user_id"
  include Export

  paginates_per 15

  def self.to_csv
    self.csv_export("id created_at name email")
  end
end
