# frozen_string_literal: true

class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :activity_date, presence: true
  validates :duration, numericality: { greater_than: 0 }, allow_nil: true

  scope :recent, -> { order(activity_date: :desc) }
  scope :by_date_range, ->(start_date, end_date) { where(activity_date: start_date..end_date) }
end
