class UserGoalSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :goal_id, :date, :completed, :notes, :created_at, :updated_at
  belongs_to :goal, serializer: GoalSerializer
end
