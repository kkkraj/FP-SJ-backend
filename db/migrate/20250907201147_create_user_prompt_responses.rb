class CreateUserPromptResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_prompt_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :journal_prompt, null: false, foreign_key: true
      t.date :date
      t.text :response

      t.timestamps
    end
  end
end
