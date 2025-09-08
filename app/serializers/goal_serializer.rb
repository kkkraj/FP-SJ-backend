class GoalSerializer < ActiveModel::Serializer
  attributes :id, :goal_text, :category, :description, :created_at, :updated_at
end
