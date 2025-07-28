# frozen_string_literal: true

class DiaryEntry < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 10_000 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :entry_date, presence: true

  scope :recent, -> { order(entry_date: :desc) }
  scope :by_date_range, ->(start_date, end_date) { where(entry_date: start_date..end_date) }

  def self.search(query)
    where('title ILIKE ? OR content ILIKE ?', "%#{query}%", "%#{query}%")
  end
end
