class Team < ApplicationRecord
  has_many :goals

  has_many :children, class_name: :Team, foreign_key: :parent_id, dependent: :nullify
  belongs_to :parent, class_name: :Team, optional: true

  #Just the ones wihout parents (the "Objectives")
  has_many :objectives, -> {where("parent_id is null")}, class_name: "Goal"

end
