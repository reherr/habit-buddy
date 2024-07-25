# == Schema Information
#
# Table name: habit_entries
#
#  id         :integer          not null, primary key
#  entry_date :date
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer
#
class HabitEntry < ApplicationRecord
  belongs_to :habit, required: true, class_name: "Habit", foreign_key: "habit_id"
  
end
