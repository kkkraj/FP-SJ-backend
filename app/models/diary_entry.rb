# frozen_string_literal: true

class DiaryEntry < ApplicationRecord
  belongs_to :user

  validates :content, length: { maximum: 10_000 }, allow_blank: true
  validates :title, length: { maximum: 255 }, allow_blank: true
  validates :entry_date, presence: true
  
  before_save :set_default_title

  scope :recent, -> { order(entry_date: :desc) }
  scope :by_date_range, ->(start_date, end_date) { where(entry_date: start_date..end_date) }

  def self.search(query)
    where('title ILIKE ? OR content ILIKE ?', "%#{query}%", "%#{query}%")
  end

  private

  def set_default_title
    if title.blank?
      # Create a title from the first 50 characters of content, or use a default
      content_preview = content&.strip&.first(50)
      self.title = content_preview.present? ? "#{content_preview}..." : "Diary Entry - #{entry_date}"
    end
  end
end
