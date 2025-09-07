class GratitudeSerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :description, :created_at, :updated_at
end
