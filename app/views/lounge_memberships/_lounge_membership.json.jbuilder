json.extract! lounge_membership, :id, :first_name, :last_name, :email, :phone_number, :lounge_id, :created_at, :updated_at
json.url lounge_membership_url(lounge_membership, format: :json)
