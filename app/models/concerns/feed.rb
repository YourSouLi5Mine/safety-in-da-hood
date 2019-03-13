module Feed
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
