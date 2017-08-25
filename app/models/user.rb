class EmailValidator < ActiveModel::Validator
  def validate(record)
    domain = Rails.application.config.valid_email_domain
    unless record.email.ends_with? domain.to_s
      record.errors[:email] << "must be in the domain #{domain}."
    end
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable

  include ActiveModel::Validations
  validates_with EmailValidator

  #if Rails.application.config.valid_email_domain.present?
  #  domain = Rails.application.config.valid_email_domain
  #  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@#{domain}\z/, message: "must be within the domain '#{domain}'."}
  #end

  validates :email, uniqueness: true
  validates :email, presence: true

  #TODO: Do this...
  #https://stackoverflow.com/questions/21817019/rails-polymorphic-favorites-user-can-favorite-different-models
  #or this...https://snippets.aktagon.com/snippets/588-how-to-implement-favorites-in-rails-with-polymorphic-associations

  has_many :favorites
  has_many :goals
  has_many :favorite_goals, :through => :favorites, :source => :favorable, :source_type => "Goal"
  #has_many :favorite_teams, :through => :favorites, :source => :favorable, :source_type => "Team"
end
