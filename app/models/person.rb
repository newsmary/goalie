class Person < ApplicationRecord
  #use our existing users table (managed by devise)
  self.table_name= :users
  default_scope { order(:name) }
  validates :email, uniqueness: true
  has_many :goals, foreign_key: "user_id"
  include ImportExport

  paginates_per 15

  HEADERS = %w"id created_at name email"
end
