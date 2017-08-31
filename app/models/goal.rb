class Goal < ApplicationRecord
  validates :name, presence: true

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

  def score
    scores.first
  end

  #untested... a way to say if something is an objective or key result
  def type
    (parent.present?) ? "Key result" : "Objective"
  end

  #alias
  def grade
    score
  end

  def status
    #default to status with lowest ordinal
    score.nil? ? Status.order(:ordinal).first : score.status
  end

  #for now...
  def owner
    team
  end

  def display_amount
    (score.nil? ? 0 : score.amount).to_s + "%"
  end

  def siblings
    parent.present? ? parent.children : owner.objectives
  end

  #alias...
  def children
    key_results
  end

  #alias...
  def sub_goals
    key_results
  end

  def next_goal
    current_index = siblings.to_a.index(self)
    siblings.to_a[current_index+1]
  end

  def previous_goal
      current_index = siblings.to_a.index(self)
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

end
