class Goal < ApplicationRecord
  #belongs_to :goalable, polymorphic: true
  belongs_to :team
  #has_one :team
end
