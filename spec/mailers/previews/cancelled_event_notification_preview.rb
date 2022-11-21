# Preview all emails at http://localhost:3000/rails/mailers/cancelled_event_notification
class CancelledEventNotificationPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/cancelled_event_notification/cancel_notify_followers
  def cancel_notify_followers
    CancelledEventNotificationMailer.with(favoritor: event_favoritor, event: Event.last).cancel_notify_followers
  end

  def cancel_notify_members
    CancelledEventNotificationMailer.with(membership: membership, event: Event.last).cancel_notify_members
  end

  private

  def event
    Event.last
  end

  def event_favoritor
    Event.last.lounge.favoritors.last
  end

  def membership
    Event.last.lounge.memberships.last
  end
end
