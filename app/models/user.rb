class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #:confirmable

  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@bbc\.co\.uk\z/, message: "must be within the bbc.co.uk domain"}

end
