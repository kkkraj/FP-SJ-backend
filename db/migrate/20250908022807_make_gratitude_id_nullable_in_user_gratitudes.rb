class MakeGratitudeIdNullableInUserGratitudes < ActiveRecord::Migration[6.0]
  def change
    change_column_null :user_gratitudes, :gratitude_id, true
  end
end
