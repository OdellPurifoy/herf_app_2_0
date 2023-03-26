# Preview all emails at http://localhost:3000/rails/mailers/one_day_reminder
class OneDayReminderPreview < ActionMailer::Preview
  def remind_members
    OneDayReminderMailer.with(membership: membership, event: event).remind_members
  end

  private

  def event
    Event.last
  end

  def membership
    Event.last.lounge.memberships.last
  end
end
