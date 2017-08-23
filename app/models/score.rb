class Score < ApplicationRecord
  belongs_to :user
  belongs_to :goal
  belongs_to :status
  validates_presence_of :amount
  validates_presence_of :reason

end
