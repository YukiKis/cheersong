class Song < ApplicationRecord
  belongs_to :user
  has_many :addresses, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :name, presence: true
  validates :description, length: { maximum: 500 }
  
  def favorited_by?(user)
    self.favorites.find_by(user_id: user.id)
  end
end
