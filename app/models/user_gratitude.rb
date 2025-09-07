class UserGratitude < ApplicationRecord
  belongs_to :user
  belongs_to :gratitude

  validates :user_id, :gratitude_id, :date, presence: true
  validates :user_id, uniqueness: { scope: [:gratitude_id, :date] }
end
