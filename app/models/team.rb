class Team < ApplicationRecord
  has_many :goals

  #Just the ones wihout parents (the "Objectives")
  has_many :objectives, -> {where("parent_id is null")}, :class_name=>'Goal'

end
