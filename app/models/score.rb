class Score < ApplicationRecord
  belongs_to :user
  belongs_to :goal
  belongs_to :status
end
