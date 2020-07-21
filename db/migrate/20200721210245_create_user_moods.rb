class CreateUserMoods < ActiveRecord::Migration[6.0]
  def change
    create_table :user_moods do |t|
      t.integer :user_id
      t.integer :mood_id

      t.timestamps
    end
  end
end
