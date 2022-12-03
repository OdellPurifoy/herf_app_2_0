json.extract! rsvp, :id, :first_name, :last_name, :phone_number, :email, :user_id, :event_id, :created_at, :updated_at
json.url rsvp_url(rsvp, format: :json)
