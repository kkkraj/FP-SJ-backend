# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :diary_entries, dependent: :destroy
  has_many :user_moods, dependent: :destroy
  has_many :moods, through: :user_moods
  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 3, maximum: 50 }
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: 'can only contain letters, numbers, and underscores' }
  validates :password, length: { minimum: 6 }, if: :password_required?

  before_save :downcase_username

  private

  def password_required?
    new_record? || password.present?
  end

  def downcase_username
    username.downcase! if username.present?
  end
end
