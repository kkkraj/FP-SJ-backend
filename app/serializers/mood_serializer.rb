class MoodSerializer < ActiveModel::Serializer
  attributes :id, :mood_name, :mood_url
end
