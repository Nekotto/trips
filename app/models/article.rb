class Article < ApplicationRecord
  belongs_to :user
  
  has_one_attached :profile_image
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true, length:{maximum:30}
  validates :body, presence: true, length:{maximum:10000}
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def favorited_by?(user)
    if user
      favorites.exists?(user_id: user.id)
    else
      false
    end
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "title", "updated_at", "user_id"]
  end
  
end