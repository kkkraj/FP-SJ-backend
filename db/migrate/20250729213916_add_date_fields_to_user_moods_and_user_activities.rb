class AddDateFieldsToUserMoodsAndUserActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :user_moods, :mood_date, :date
    add_column :user_activities, :activity_date, :date
    add_column :user_activities, :duration, :integer
  end
end
