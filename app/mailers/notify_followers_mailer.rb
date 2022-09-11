class NotifyFollowersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_followers_mailer.notify_followers.subject
  #
  def notify_followers
    @greeting = "Hi"

    mail( 
      from: "herf@support.com",
      to: Lounge.last.favoritors.last.email, 
      cc: User.all.pluck(:email), 
      subject: "You're invited to our new event!"
    )
  end
end
