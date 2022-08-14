json.extract! event, :id, :name, :event_type, :start_time_display, :end_time_display, :maximum_capacity, :rsvp_needed, :event_date, :lounge_id, :created_at, :updated_at
json.url event_url(event, format: :json)
