class UserGratitudeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :gratitude_id, :date, :notes, :created_at, :updated_at
  belongs_to :gratitude, serializer: GratitudeSerializer
end
