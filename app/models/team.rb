class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :parent_id,message: "must be unique within the scope of its parent." }

  default_scope{ order('name') }
  has_many :goals
  has_many :children,-> { order :created_at}, class_name: :Team, foreign_key: :parent_id, dependent: :nullify
  belongs_to :parent, class_name: :Team, optional: true
  #Just the ones wihout parents (the "Objectives")
  has_many :objectives, -> {where("parent_id is null").order(end_date: :desc)}, class_name: "Goal"

  has_many :favorites, :as => :favorable
  has_many :fans, :through => :favorites, :source => :user
  include ImportExport

  #required fields for CSV  export
  HEADERS = %w{id name body parent_id}

  #TODO....
  def self.teams_with_objectives_ending(end_date)
    #Team.where(parent: nil).each do |t|
  end

  def has_objectives_in_quarter?(end_date)
    if(objectives_by_quarter(end_date) > 0)
      return true
    else

    end
  end

  def objectives_last_quarter
    objectives_by_end_date (Date.today - 3.months).end_of_financial_quarter
  end

  def objectives_next_quarter
    objectives_by_end_date Date.today.next_financial_quarter.end_of_financial_quarter
  end

  def objectives_by_end_date(end_date)
    objectives.where(end_date: end_date)
  end

  #alias... not actually appropriate since the param is a date not a quarter...
  #better to use _by_end_date above
  def objectives_by_quater(end_date)
    objectives.where(end_date: end_date)
  end

  def objectives_this_quarter
    objectives_by_end_date Date.today.end_of_financial_quarter
  end
end
