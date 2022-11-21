# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/updated_event_notification/update_notify_followers
class UpdatedEventNotificationPreview < ActionMailer::Preview
  def event
    Event.last
  end

  def favoritor
    Event.last.lounge.favoritors.last
  end

  def membership
    Event.last.lounge.memberships.last
  end

  def cancel_notify_members
    CancelledEventNotificationMailer.with(membership: membership, event: Event.last).cancel_notify_followers
  end

  def update_notify_followers
    UpdatedEventNotificationMailer.with(favoritor: favoritor, event: event).update_notify_followers
  end
end
