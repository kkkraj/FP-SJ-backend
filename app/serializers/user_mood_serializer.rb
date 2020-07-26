class UserMoodSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :mood_id, :created_at
end
