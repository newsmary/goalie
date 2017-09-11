class LessonsLearnedValidator < ActiveModel::Validator
  def validate(record)
    #If the selected status requires lessons learned, make sure we have some before saving
    if record.status.require_learnings? && ! record.learnings?
      record.errors[:base] << "Please share what you've learned by working on this goal."
    end
  end
end


class Score < ApplicationRecord
  include Export
  belongs_to :user
  belongs_to :goal
  belongs_to :status
  validates_presence_of :amount
  validates_presence_of :reason
  #validates_presence_of :lessons, :if => lambda {self.status && self.status.require_learnings?}
  validates_with LessonsLearnedValidator


  def display_reason
    reason.gsub(/\r\n/,"<br>")
    #sanitize(reason.gsub(/\r\n/,"<br>"), tags: %w(br strong em b i ul li))
  end

  def status_name
    status.name
  end

  def goal_name
    goal.name
  end

  def self.to_csv
    self.csv_export("id created_at goal_id goal_name amount status_name status_id reason learnings user_id user_name")
  end

  def user_name
    user.name
  end

  #todo: DRY this into a concern
=begin
  def self.to_csv
    require 'csv'
    attributes = %w{id created_at goal_id goal_name amount status_name status_id reason learnings user_id user_name}

    CSV.generate(headers: true) do |csv|
      csv << attributes #headers

      all.each do |line|
        csv << attributes.map{ |attr| line.send(attr) }
      end
    end
  end
=end
end
