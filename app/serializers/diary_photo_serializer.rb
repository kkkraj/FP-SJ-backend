# frozen_string_literal: true

class DiaryPhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo_date, :created_at, :updated_at, :photo_url, :diary_entry_id, :user_id
  
  belongs_to :user
  belongs_to :diary_entry, optional: true
  
  def photo_url
    if object.photo.attached?
      # Always generate full URL with host
      host = Rails.application.routes.default_url_options[:host] || 'localhost'
      port = Rails.application.routes.default_url_options[:port] || 3000
      base_url = "http://#{host}:#{port}"
      
      Rails.application.routes.url_helpers.rails_blob_url(object.photo, host: base_url)
    else
      nil
    end
  end
end 