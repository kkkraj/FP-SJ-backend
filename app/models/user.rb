class User < ApplicationRecord
    has_secure_password

    has_many :diary_entries
    has_many :user_moods
    has_many :moods, through: :user_moods
    has_many :user_activities
    has_many :activities, through: :user_activities

    validates :username, presence: true
    validates :username, uniqueness: true
end
