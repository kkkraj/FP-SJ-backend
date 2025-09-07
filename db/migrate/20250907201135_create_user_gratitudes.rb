class CreateUserGratitudes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_gratitudes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gratitude, null: false, foreign_key: true
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
