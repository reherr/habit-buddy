class AddUserIdToHabitEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_entries, :user_id, :integer
    add_index :habit_entries, :user_id
    add_foreign_key :habit_entries, :users
  end
end
