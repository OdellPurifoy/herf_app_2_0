json.extract! lounge, :id, :name, :address_street_1, :address_street_2, :city, :state, :zip_code, :details, :opening_time, :closing_time, :user_id, :created_at, :updated_at
json.url lounge_url(lounge, format: :json)
json.details lounge.details.to_s
