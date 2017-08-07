class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@bbc\.co\.uk\z/, message: "must be within the bbc.co.uk domain"}
  validates :email, uniqueness: true

  #TODO: Do this...
  #https://stackoverflow.com/questions/21817019/rails-polymorphic-favorites-user-can-favorite-different-models
  #or this...https://snippets.aktagon.com/snippets/588-how-to-implement-favorites-in-rails-with-polymorphic-associations

  has_many :favorites
  has_many :favorite_goals, :through => :favorites, :source => :favorable, :source_type => "Goal"
  has_many :favorite_teams, :through => :favorites, :source => :favorable, :source_type => "Team"
end
