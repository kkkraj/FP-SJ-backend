class Gratitude < ApplicationRecord
  has_many :user_gratitudes, dependent: :destroy
  has_many :users, through: :user_gratitudes

  validates :title, presence: true
  validates :category, presence: true
end
