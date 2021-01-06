class Song < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :description, length: { maximum: 500 }
end
