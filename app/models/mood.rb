# frozen_string_literal: true

class Mood < ApplicationRecord
  has_many :user_moods, dependent: :destroy
  has_many :users, through: :user_moods

  validates :mood_name, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(:name) }
end
