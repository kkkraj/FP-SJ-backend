class Goal < ApplicationRecord
  has_many :user_goals, dependent: :destroy
  has_many :users, through: :user_goals

  validates :goal_text, presence: true, length: { maximum: 200 }
  validates :category, length: { maximum: 100 }, allow_blank: true
end
