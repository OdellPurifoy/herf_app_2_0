# Preview all emails at http://localhost:3000/rails/mailers/new_rsvp
class NewRsvpPreview < ActionMailer::Preview
  def rsvp
    Rsvp.last
  end

  # Preview this email at http://localhost:3000/rails/mailers/new_rsvp/notify_user
  def notify_user
    NewRsvpMailer.with(rsvp: rsvp).notify_user
  end
end
