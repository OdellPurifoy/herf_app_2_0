# Preview all emails at http://localhost:3000/rails/mailers/cancelled_event_notification
class CancelledEventNotificationPreview < ActionMailer::Preview
  def event
    Event.last
  end

  def favoritor
    Event.last.lounge.favoritors.last
  end

  # Preview this email at http://localhost:3000/rails/mailers/cancelled_event_notification/cancel_notify_followers
  def cancel_notify_followers
    CancelledEventNotificationMailer.with(favoritor: favoritor, event: Event.last).cancel_notify_followers
  end
end
