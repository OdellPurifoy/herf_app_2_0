json.extract! membership, :id, :first_name, :last_name, :email, :phone_number, :lounge_id, :created_at, :updated_at
json.url membership_url(membership, format: :json)
