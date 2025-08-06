# frozen_string_literal: true

class DiaryPhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo_date, :created_at, :updated_at, :photo_url, :diary_entry_id
  
  belongs_to :user
  belongs_to :diary_entry, optional: true
  
  def photo_url
    if object.photo.attached?
      begin
        Rails.application.routes.url_helpers.rails_blob_url(object.photo, only_path: false)
      rescue ArgumentError => e
        if e.message.include?('Missing host')
          # Fallback to relative path if host is not configured
          Rails.application.routes.url_helpers.rails_blob_path(object.photo, only_path: true)
        else
          raise e
        end
      end
    else
      nil
    end
  end
end 