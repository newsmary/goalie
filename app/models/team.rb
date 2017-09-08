class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  default_scope{ order('name') }
  has_many :goals
  has_many :children,-> { order :created_at}, class_name: :Team, foreign_key: :parent_id, dependent: :nullify
  belongs_to :parent, class_name: :Team, optional: true
  #Just the ones wihout parents (the "Objectives")
  has_many :objectives, -> {where("parent_id is null").order(end_date: :desc)}, class_name: "Goal"

  has_many :favorites, :as => :favorable
  has_many :fans, :through => :favorites, :source => :user

  def objectives_next_quarter
    objectives.where(end_date: Date.today.next_financial_quarter.end_of_financial_quarter)
  end

  def objectives_this_quarter
    objectives.where(end_date: Date.today.end_of_financial_quarter)
  end


end
