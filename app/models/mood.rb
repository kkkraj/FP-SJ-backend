# frozen_string_literal: true

class Mood < ApplicationRecord
  has_many :user_moods, dependent: :destroy
  has_many :users, through: :user_moods

  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 500 }

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(:name) }
end
