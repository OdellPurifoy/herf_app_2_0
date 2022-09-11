# Preview all emails at http://localhost:3000/rails/mailers/notify_followers_mailer
class NotifyFollowersMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notify_followers_mailer/notify_followers
  def notify_followers
    NotifyFollowersMailer.notify_followers
  end

end
