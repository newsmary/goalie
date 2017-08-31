class LessonsLearnedValidator < ActiveModel::Validator
  def validate(record)
    #If the selected status requires lessons learned, make sure we have some before saving
    if record.status.require_learnings? && ! record.learnings?
      record.errors[:base] << "Please share what you've learned by working on this goal."
    end
  end
end


class Score < ApplicationRecord
  belongs_to :user
  belongs_to :goal
  belongs_to :status
  validates_presence_of :amount
  validates_presence_of :reason
  #validates_presence_of :lessons, :if => lambda {self.status && self.status.require_learnings?}
  validates_with LessonsLearnedValidator


  def display_reason
    reason.gsub(/\r\n/,"<br>").html_safe
  end

end
