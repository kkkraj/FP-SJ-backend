class CreateGratitudes < ActiveRecord::Migration[6.0]
  def change
    create_table :gratitudes do |t|
      t.string :title
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
