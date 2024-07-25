desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  p "Creating sample data"

  if Rails.env.development?
    HabitEntry.destroy_all
    Habit.destroy_all
    User.destroy_all
  end

  10.times do
    name = Faker::Name.first_name
    user = User.new
    user.email = "#{name}@example.com"
    user.password = "password"
    user.username = name
    user.save

    3.times do
      habit = Habit.new
      habit.name = Faker::Hobby.activity
      habit.description = Faker::Lorem.sentence
      habit.start_date = Date.today - rand(1..10).days
      habit.user_id = user.id
      habit.save

      5.times do
        habit_entry = HabitEntry.new
        habit_entry.entry_date = Date.today - rand(1..10).days
        habit_entry.status = [true, false].sample
        habit_entry.habit_id = habit.id
        habit_entry.save
      end
    end
  end

  p "There are now #{User.count} users."
  p "There are now #{Habit.count} habits."
  p "There are now #{HabitEntry.count} habit entries."

end
