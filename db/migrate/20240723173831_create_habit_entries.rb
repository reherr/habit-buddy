class CreateHabitEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_entries do |t|
      t.integer :habit_id
      t.date :entry_date
      t.boolean :status

      t.timestamps
    end
  end
end
