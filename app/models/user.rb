class User < ApplicationRecord
  validates :username, :email, presence: true, uniqueness: true
  validates :email, email: true
  validates :password, confirmation: true
  has_secure_password
end
