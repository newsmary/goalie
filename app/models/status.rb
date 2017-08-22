class Status < ApplicationRecord
  default_scope { order(ordinal: :asc) }
end
