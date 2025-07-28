# frozen_string_literal: true

class UserMood < ApplicationRecord
  belongs_to :user
  belongs_to :mood

  validates :mood_date, presence: true
  validates :user_id, uniqueness: { scope: :mood_date, message: 'can only have one mood per day' }

  scope :recent, -> { order(mood_date: :desc) }
  scope :by_date_range, ->(start_date, end_date) { where(mood_date: start_date..end_date) }
end
