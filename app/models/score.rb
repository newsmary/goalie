class Score < ApplicationRecord
  include ImportExport
  belongs_to :user
  belongs_to :goal
  #belongs_to :status
  validates_presence_of :amount
  validates_presence_of :reason

  HEADERS = %w{id created_at goal_id goal_name amount reason learnings user_id user_name}

  def display_reason
    reason.gsub(/\r\n/,"<br>")
    #sanitize(reason.gsub(/\r\n/,"<br>"), tags: %w(br strong em b i ul li))
  end

  def status
    #if it's done (because we have learnings)
    if(learnings.present?)
      case amount
      when 0..40
        Status.new(name: "Not delivered", hex_color: "#9d1c1f")
      when 41..70
        Status.new(name: "Partially delivered", hex_color: "#FC0")
      else
        Status.new(name: "Delivered!", hex_color: "#5a8c3e")
      end
    else
      case confidence
      when 0..40
        Status.new(name: "In trouble", hex_color: "#9d1c1f")
      when 41..70
        Status.new(name: "At risk", hex_color: "#FC0")
      else
        Status.new(name: "On track", hex_color: "#5a8c3e")
      end
    end
  end

  def status_name
    status.name
  end

  def goal_name
    goal.name
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
