class Song < ApplicationRecord
  belongs_to :user
  has_many :addresses, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  acts_as_taggable_on :tags
  
  validates :name, presence: true
  validates :description, length: { maximum: 500 }
  
  def favorited_by?(user)
    self.favorites.find_by(user_id: user.id)
  end
end
