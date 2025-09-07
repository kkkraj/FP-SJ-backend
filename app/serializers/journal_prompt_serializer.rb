class JournalPromptSerializer < ActiveModel::Serializer
  attributes :id, :question, :category, :description, :created_at, :updated_at
end
