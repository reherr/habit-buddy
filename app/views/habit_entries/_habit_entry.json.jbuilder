json.extract! habit_entry, :id, :habit_id, :entry_date, :status, :created_at, :updated_at
json.url habit_entry_url(habit_entry, format: :json)
