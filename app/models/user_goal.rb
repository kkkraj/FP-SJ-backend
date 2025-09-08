class UserGoal < ApplicationRecord
  belongs_to :user
  belongs_to :goal, optional: true

  validates :goal_text, presence: true, length: { maximum: 200 }
  validates :date, presence: true
  validates :user_id, presence: true
  
  scope :for_date, ->(date) { where(date: date) }
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
end
