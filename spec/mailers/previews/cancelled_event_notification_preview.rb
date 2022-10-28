# Preview all emails at http://localhost:3000/rails/mailers/cancelled_event_notification
class CancelledEventNotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/cancelled_event_notification/cancel_notify_followers
  def cancel_notify_followers
    CancelledEventNotificationMailer.cancel_notify_followers
  end

end