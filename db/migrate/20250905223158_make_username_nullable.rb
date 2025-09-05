class MakeUsernameNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :username, true
  end
end
