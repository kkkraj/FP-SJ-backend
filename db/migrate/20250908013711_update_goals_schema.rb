class UpdateGoalsSchema < ActiveRecord::Migration[6.0]
  def change
    # Update goals table to match frontend requirements
    rename_column :goals, :title, :goal_text
    
    # Update user_goals table to match frontend requirements
    add_column :user_goals, :goal_text, :text, null: false
    add_index :user_goals, [:user_id, :date]
    add_index :user_goals, :date
  end
end
