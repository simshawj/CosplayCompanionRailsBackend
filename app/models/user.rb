class User < ActiveRecord::Base
  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  def login=(login)
    @login = login
  end

end
