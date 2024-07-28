# == Schema Information
#
# Table name: habit_entries
#
#  id         :integer          not null, primary key
#  entry_date :date
#  note       :text
#  status     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :integer
#  user_id    :integer
#
# Indexes
#
#  index_habit_entries_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class HabitEntry < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :habit, required: true, class_name: "Habit", foreign_key: "habit_id"

  validates :note, length: { maximum: 500 }

  def self.ransackable_attributes(auth_object = nil)
    ["entry_date"]
  end
  
end
