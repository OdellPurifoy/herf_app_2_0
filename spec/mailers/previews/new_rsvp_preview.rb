# Preview all emails at http://localhost:3000/rails/mailers/new_rsvp
class NewRsvpPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_rsvp/notify_user
  def notify_user
    NewRsvpMailer.notify_user
  end

end
