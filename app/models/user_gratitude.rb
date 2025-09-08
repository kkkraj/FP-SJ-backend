class UserGratitude < ApplicationRecord
  belongs_to :user
  belongs_to :gratitude, optional: true

  validates :user_id, :date, presence: true
  validates :gratitude_text, presence: true, if: -> { gratitude_id.blank? }
  validates :gratitude_id, presence: true, if: -> { gratitude_text.blank? }
  validates :user_id, uniqueness: { scope: [:gratitude_id, :date] }, if: -> { gratitude_id.present? }
  validates :user_id, uniqueness: { scope: [:gratitude_text, :date] }, if: -> { gratitude_text.present? }
  
  validate :either_gratitude_text_or_id_present

  private

  def either_gratitude_text_or_id_present
    if gratitude_text.blank? && gratitude_id.blank?
      errors.add(:base, "Either gratitude_text or gratitude_id must be present")
    end
    if gratitude_text.present? && gratitude_id.present?
      errors.add(:base, "Cannot have both gratitude_text and gratitude_id")
    end
  end
end
