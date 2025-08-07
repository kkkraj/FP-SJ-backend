# frozen_string_literal: true

class DiaryPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :diary_entry, optional: true
  
  has_one_attached :photo
  
  validates :photo, presence: true
  
  # Validate photo file type using Active Storage
  validate :acceptable_photo
  
  scope :recent, -> { order(created_at: :desc) }
  scope :by_date, ->(date) { where(created_at: date.beginning_of_day..date.end_of_day) }
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  
  before_create :set_photo_date
  before_destroy :purge_photo
  
  private
  
  def set_photo_date
    self.photo_date = Date.current
  end
  
  def purge_photo
    photo.purge if photo.attached?
  end
  
  def acceptable_photo
    return unless photo.attached?
    
    unless photo.blob.byte_size <= 10.megabytes
      errors.add(:photo, 'is too large (max 10MB)')
    end
    
    acceptable_types = ['image/png', 'image/jpeg', 'image/jpg', 'image/gif']
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, 'must be a PNG, JPEG, JPG, or GIF')
    end
  end
end
