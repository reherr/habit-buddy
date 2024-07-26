class AddNotesToHabitEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_entries, :note, :text
  end
end
