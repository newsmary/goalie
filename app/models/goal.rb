class Goal < ApplicationRecord
  validates :name, presence: true
  #belongs_to :goalable, polymorphic: true
  belongs_to :team
  #calling "Key Results" children to be more general
  has_many :key_results, :class_name=>'Goal', :foreign_key=>'parent_id', dependent: :nullify
  belongs_to :parent, :class_name=>'Goal', :foreign_key=>'parent_id', optional: true
  #has_one :parent, :class_name=>'Goal', :foreign_key=>'parent_id'

  #for now...
  def owner
    team
  end

  def siblings
    parent.present? ? parent.children : owner.objectives
  end

  #alias...
  def children
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
end
