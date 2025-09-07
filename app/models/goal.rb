class Goal < ApplicationRecord
  has_many :user_goals, dependent: :destroy
  has_many :users, through: :user_goals

  validates :title, presence: true
  validates :category, presence: true
end
