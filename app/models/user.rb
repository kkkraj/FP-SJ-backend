# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :diary_entries, dependent: :destroy
  has_many :user_moods, dependent: :destroy
  has_many :moods, through: :user_moods
  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities
  has_many :diary_photos, dependent: :destroy
  has_many :user_goals, dependent: :destroy
  has_many :goals, through: :user_goals
  has_many :user_gratitudes, dependent: :destroy
  has_many :gratitudes, through: :user_gratitudes
  has_many :user_prompt_responses, dependent: :destroy
  has_many :journal_prompts, through: :user_prompt_responses
  has_one_attached :profile_photo

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true
  validates :username, length: { minimum: 3, maximum: 50 }, allow_blank: true
  validates :username, format: { with: /\A[a-zA-Z0-9_]+\z/, message: 'can only contain letters, numbers, and underscores' }, allow_blank: true
  validates :password, length: { minimum: 6 }, if: :password_required?

  before_save :downcase_username

  # Password reset functionality
  def generate_password_reset_token
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_sent_at = Time.current
    save!
  end

  def password_reset_token_valid?
    reset_password_sent_at && reset_password_sent_at > 1.hour.ago
  end

  def clear_password_reset_token
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
    save!
  end

  private

  def password_required?
    new_record? || password.present?
  end

  def downcase_username
    username.downcase! if username.present?
  end
end
