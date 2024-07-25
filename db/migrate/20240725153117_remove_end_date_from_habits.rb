class RemoveEndDateFromHabits < ActiveRecord::Migration[7.1]
  def change
    remove_column :habits, :end_date, :date
  end
end
