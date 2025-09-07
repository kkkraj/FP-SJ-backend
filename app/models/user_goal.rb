class UserGoal < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :user_id, :goal_id, :date, presence: true
  validates :user_id, uniqueness: { scope: [:goal_id, :date] }
end
