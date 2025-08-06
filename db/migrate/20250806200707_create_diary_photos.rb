class CreateDiaryPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :diary_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :diary_entry, null: true, foreign_key: true
      t.date :photo_date

      t.timestamps
    end
    
    add_index :diary_photos, :photo_date
  end
end
