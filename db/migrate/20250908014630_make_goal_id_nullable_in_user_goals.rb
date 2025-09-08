class MakeGoalIdNullableInUserGoals < ActiveRecord::Migration[6.0]
  def change
    change_column_null :user_goals, :goal_id, true
  end
end
