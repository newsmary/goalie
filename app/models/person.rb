class Person < ApplicationRecord
  #use our existing users table (managed by devise)
  self.table_name= :users
  default_scope { order(:name) }
  validates :email, uniqueness: true

  paginates_per 15

end
