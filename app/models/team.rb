class Team < ApplicationRecord
  has_many :goals
  has_many :objectives, -> {where("parent_id is null")}, :class_name=>'Goal'
  #has_many :children, :class_name=>'Goal', :foreign_key=>'parent_id', dependent: :nullify

end
