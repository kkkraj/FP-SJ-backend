class CreateMoods < ActiveRecord::Migration[6.0]
  def change
    create_table :moods do |t|
      t.string :mood_name
      t.string :mood_url

      t.timestamps
    end
  end
end
