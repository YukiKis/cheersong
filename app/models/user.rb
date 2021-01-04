class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #validates :name, length: { in: 2..20 }
  
  has_many :passive_relationships, foreign_key: :followed_id, class_name: :Relationship
  has_many :active_relationships, foreign_key: :following_id, class_name: :Relationship
  has_many :followers, through: :passive_relationships, source: :following
  has_many :followings, through: :active_relationships, source: :followed
  
  def follow(user)
    self.active_relationships.create(followed: user)
  end
  
  def unfollow(user)
    r = self.active_relationships.find_by(followed: user)
    r.destroy
  end
  
  def following?(user)
    self.active_relationships.find_by(followed: user)
  end
end
