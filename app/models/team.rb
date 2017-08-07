class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  default_scope{ order('name') }
  has_many :goals
  has_many :children,-> { order :created_at}, class_name: :Team, foreign_key: :parent_id, dependent: :nullify
  belongs_to :parent, class_name: :Team, optional: true
  #Just the ones wihout parents (the "Objectives")
  has_many :objectives, -> {where("parent_id is null")}, class_name: "Goal"

  has_many :favorites, :as => :favorable
  has_many :fans, :through => :favorites, :source => :user

end
