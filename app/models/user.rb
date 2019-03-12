class User < ApplicationRecord
  extend Tokenizer

  has_many :tweets, dependent: :destroy
  has_many :active_follows, class_name:  "Follow",
                            foreign_key: "follower_id",
                            dependent:   :destroy
  has_many :passive_follows, class_name:  "Follow",
                             foreign_key: "followed_id",
                             dependent:   :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

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

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM follows
                     WHERE follower_id = :user_id"
    Tweet.where("user_id IN (#{following_ids})
                 OR user_id = :user_id", user_id: id)
  end
end
