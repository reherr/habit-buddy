# == Schema Information
#
# Table name: habits
#
#  id          :integer          not null, primary key
#  description :text
#  end_date    :date
#  name        :string
#  start_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Habit < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :habit_entries, class_name: "HabitEntry", foreign_key: "habit_id", dependent: :destroy
end
