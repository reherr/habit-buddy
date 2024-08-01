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
  belongs_to :habit, required: true, class_name: 'Habit', foreign_key: 'habit_id'

  validates :note, length: { maximum: 500 }

  validate :entry_date_cannot_be_in_the_future

  validate :unique_entry_per_day_per_habit, if: -> { new_record? || entry_date_changed? }

  before_validation :set_default_entry_date, on: :create

  def self.ransackable_attributes(_auth_object = nil)
    ['entry_date']
  end

  private

  def set_default_entry_date
    self.entry_date ||= Date.today
  end

  def entry_date_cannot_be_in_the_future
    return unless entry_date.present? && entry_date > Date.today

    errors.add(:entry_date, 'cannot be in the future')
  end

  def unique_entry_per_day_per_habit
    return unless HabitEntry.where.not(id:).where(entry_date:, habit_id:).exists?

    errors.add(:entry_date, 'You can only have one entry per day per habit')
  end
end
