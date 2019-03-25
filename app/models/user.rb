class User < ApplicationRecord
  extend Tokenizer
  include Session
  include Feed

  has_many :tweets, dependent: :destroy
  has_many :active_follows, class_name:  "Follow",
                            foreign_key: "follower_id",
                            dependent:   :destroy
  has_many :passive_follows, class_name:  "Follow",
                             foreign_key: "followed_id",
                             dependent:   :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  validates :username, :email, presence: true, uniqueness: true
  validates :email, format: { with: /[^\s]@[^\s]/ }
  validates :password, confirmation: true, allow_nil: true

  has_secure_password
end
