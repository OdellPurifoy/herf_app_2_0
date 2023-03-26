# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notify_followers_mailer
class NotifyFollowersMailerPreview < ActionMailer::Preview
  def cancel_notify_members
    CancelledEventNotificationMailer.with(membership: membership, event: event).cancel_notify_members
  end

  # Preview this email at http://localhost:3000/rails/mailers/notify_followers_mailer/notify_followers
  def notify_followers
    NotifyFollowersMailer.with(favoritor: event_favoritor, event: event).notify_followers
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
