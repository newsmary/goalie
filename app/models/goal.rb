class DateValidator < ActiveModel::Validator
  def validate(record)
    #If the selected status requires lessons learned, make sure we have some before saving
    if record.parent.present? && record.end_date != record.parent.end_date
      record.errors[:base] << "End date must match parent end date."
    end
  end
end
class Goal < ApplicationRecord
  validates :name, presence: true
  validates_with DateValidator


  has_many :links
  has_many :linked_goals, through: :links

  has_many :inverse_links, class_name: :Link, foreign_key: :linked_goal_id
  has_many :inverse_linked_goals, through: :inverse_links, source: :goal


  #belongs_to :goalable, polymorphic: true
  belongs_to :team
  belongs_to :person, class_name: 'Person', foreign_key: 'user', optional: true
  #calling "Key Results" children to be more general
  has_many :key_results, -> {order :created_at}, class_name: 'Goal', foreign_key: 'parent_id', dependent: :nullify
  #has_many :key_results, class_name: 'Goal', foreign_key: 'parent_id', dependent: :nullify, -> {order "created_at"}
  #has_many :key_results, :class_name=>'Goal', :foreign_key=>'parent_id', dependent: :nullify

  belongs_to :parent, :class_name=>'Goal', :foreign_key=>'parent_id', optional: true
  #belongs_to :owner, :class_name=>'Person', :foreign_key=>
  #has_one :parent, :class_name=>'Goal', :foreign_key=>'parent_id'

  has_many :favorites, :as => :favorable
  has_many :fans, :through => :favorites, :source => :user

  has_many :scores, -> { order('created_at DESC') },  dependent: :destroy

  before_validation :check_end_dates

  def score
    scores.first
  end

  def learnings
    scores.first.learnings
  end

  #untested... a way to say if something is an objective or key result
  def type
    (parent.present?) ? "key result" : "objective"
  end

  def quarter
    end_date.financial_quarter
  end

  #convenience method to identify goals which are "done"
  def done?
    #assume a status requiring "learnings" designates a "done" state
    #TODO: add a "done" flag to statuses
    status.require_learnings?
  end

  #alias
  def grade
    score
  end

  def status
    #default to status with lowest ordinal
    score.nil? ? Status.where(ordinal:0).first : score.status
  end

  #for now...
  def owner
    team
  end

  def display_amount
    (score.nil? ? 0 : score.amount).to_s + "%"
  end

  def siblings
    parent.present? ? parent.children.where(end_date: parent.end_date) : owner.objectives.where(end_date: end_date)
  end

  #alias...
  def children
    key_results
  end

  def has_children?
    !children.empty?
  end

  #alias...
  def sub_goals
    key_results
  end

  #combine goals that we link to and all goals that link to us (bi-directional)
  def all_linked_goals
    (linked_goals + inverse_linked_goals).to_a.uniq
  end

  def has_related_goals?
    !all_linked_goals.empty?
  end

  # unlink target goal from this one in BOTH directions
  # the bi-directionality of this is why we do it here and not in the "links" controller or model
  def unlink(target_goal)
    linked_goals.delete(target_goal)
    inverse_linked_goals.delete(target_goal)
  end

  #unlink any outbound or inbound links between this goal and the given goal
  #def unlink(linked_goal)
  #   linked_goal.
  #end

  def next_goal
    return unless siblings.present?
    current_index = siblings.to_a.index(self).to_i
    siblings.to_a[current_index+1]
  end

  def previous_goal
      return unless siblings.present?
      current_index = siblings.to_a.index(self).to_i
      if(current_index > 0)
        siblings.to_a[current_index-1]
      end
  end

=begin
  #SOMEDAY... refactor the controller search into the model here...
  #def self.search(words)
    if(words)
      #all matching goals and goals owned by matching users
      #where('lower(name) LIKE ?',"%#{words.downcase}%") + User.where("lower(name) LIKE ? ","%#{words.downcase}%").collect{|u| u.goals}.flatten

    else
      all
    end
  end
=end

  private
    #ensure the end date is the same as the parent
    def check_end_dates
        #default to end of this quarter if no date supplied
      if !self.end_date.present?
        self.end_date = Date.today.end_of_financial_quarter
      end

      if self.parent.present?
        self.end_date = self.parent.end_date
        #raise self.end_date.to_s
      end

      #update children to match
      self.children.each do |child|
        #skip callbacks
        child.update_column(:end_date, self.end_date)
      end

    end

end
