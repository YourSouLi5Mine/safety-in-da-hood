class Tweet < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 280 }
  validate :picture_size

  private
  def picture_size
    if picture.size > 3.megabytes
      errors.add(:picture, "Picture should be less than 3MB")
    end
  end
end
