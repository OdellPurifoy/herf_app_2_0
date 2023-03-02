json.extract! notification, :id, :body, :read, :user_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
