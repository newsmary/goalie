class Goal < ApplicationRecord
  #belongs_to :goalable, polymorphic: true
  belongs_to :team
  #calling "Key Results" children to be more general
  has_many :children, :class_name=>'Goal', :foreign_key=>'parent_id', dependent: :nullify
  has_many :key_results, :class_name=>'Goal', :foreign_key=>'parent_id', dependent: :nullify
  belongs_to :parent, :class_name=>'Goal', :foreign_key=>'parent_id', optional: true
  #has_one :parent, :class_name=>'Goal', :foreign_key=>'parent_id'

  def next_goal
      if(parent.present?)
        current_index = parent.children.to_a.index(self)
        parent.children.to_a[current_index+1]      
      end
  end

end
