class User < ActiveRecord::Base
  has_secure_password
  attr_readonly :email

  validates :points, numericality: { only_integer: true }
   validates :auth_token, uniqueness: true
   validates :email, presence: true, uniqueness: true
end
