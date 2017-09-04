class Link < ApplicationRecord
  belongs_to :goal
  belongs_to :linked_goal, class_name: :Goal
end
