class Team < ApplicationRecord
  has_many :goals
  #has_many :objectives, -> (object) {where("")}
end
