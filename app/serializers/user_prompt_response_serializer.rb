class UserPromptResponseSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :journal_prompt_id, :date, :response, :created_at, :updated_at
  belongs_to :journal_prompt, serializer: JournalPromptSerializer
end
