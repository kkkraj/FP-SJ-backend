class AddEntryDateToDiaryEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :diary_entries, :entry_date, :date
  end
end
