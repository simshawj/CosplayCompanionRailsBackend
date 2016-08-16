class User < ActiveRecord::Base
  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
