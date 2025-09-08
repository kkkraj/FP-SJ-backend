class AddGratitudeTextToUserGratitudes < ActiveRecord::Migration[6.0]
  def change
    add_column :user_gratitudes, :gratitude_text, :text
  end
end
