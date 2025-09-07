class CreateJournalPrompts < ActiveRecord::Migration[6.0]
  def change
    create_table :journal_prompts do |t|
      t.text :question
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
