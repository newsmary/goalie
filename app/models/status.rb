class Status < ApplicationRecord
  default_scope { order(ordinal: :asc) }
  HEADERS = %w{id name hex_color ordinal description require_learnings}
  include ImportExport
  has_many :scores


  def self.consolidate
    #loop through unique names...
    #no idea why I had to "uniq" these twice...but I did.
    self.pluck(:name).uniq.uniq do |name|
      #find all statuses with that name
      ids = self.where(name: name).pluck(:id).to_a.sort

      #find all scores with those status IDs
      Score.where(status_id: ids).each do |score|
        #assign them to the lowest matching status
        score.update(status: Status.find(ids.first))
      end

      #delete the rest
      ids.slice(1..-1).each do |id|
        Status.find(id).destroy
      end

    end
  end

end
