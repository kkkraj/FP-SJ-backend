class UserPromptResponse < ApplicationRecord
  belongs_to :user
  belongs_to :journal_prompt

  validates :user_id, :journal_prompt_id, :date, :response, presence: true
  validates :user_id, uniqueness: { scope: [:journal_prompt_id, :date] }
end
