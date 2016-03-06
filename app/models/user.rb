class User < ActiveRecord::Base
  attr_readonly :email
  attr_accessor :password, :password_confirmation

  validates :points, numericality: { only_integer: true }
   validates :auth_token, uniqueness: true
end
