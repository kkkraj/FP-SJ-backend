class JournalPrompt < ApplicationRecord
  has_many :user_prompt_responses, dependent: :destroy
  has_many :users, through: :user_prompt_responses

  validates :question, presence: true
  validates :category, presence: true
end
