# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/updated_event_notification/update_notify_followers
class UpdatedEventNotificationPreview < ActionMailer::Preview
  def cancel_notify_members
    CancelledEventNotificationMailer.with(membership: membership, event: event).cancel_notify_members
  end

  def update_notify_followers
    UpdatedEventNotificationMailer.with(favoritor: event_favoritor, event: event).update_notify_followers
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
