# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/notify_followers_mailer
class NotifyFollowersMailerPreview < ActionMailer::Preview
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

  # Preview this email at http://localhost:3000/rails/mailers/notify_followers_mailer/notify_followers
  def notify_followers
    NotifyFollowersMailer.with(favoritor: favoritor, event: Event.last).notify_followers
  end
end
