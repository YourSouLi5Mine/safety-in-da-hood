class User < ApplicationRecord
  extend Tokenizer

  attr_accessor :remember_token

  validates :username, :email, presence: true, uniqueness: true
  validates :email, email: true
  validates :password, confirmation: true, allow_nil: true
  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
