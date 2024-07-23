json.extract! habit, :id, :name, :description, :start_date, :end_date, :user_id, :created_at, :updated_at
json.url habit_url(habit, format: :json)
