# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/updated_event_notification/update_notify_followers
class UpdatedEventNotificationPreview < ActionMailer::Preview
  def update_notify_followers
    UpdatedEventNotificationMailer.with(event: Event.last).update_notify_followers
  end
end
