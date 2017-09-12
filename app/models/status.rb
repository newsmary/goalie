class Status < ApplicationRecord
  default_scope { order(ordinal: :asc) }
  HEADERS = %w{id name hex_color ordinal description require_learnings}
  include ImportExport

end
