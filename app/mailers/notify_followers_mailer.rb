class NotifyFollowersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_followers_mailer.notify_followers.subject
  #
  def notify_followers
    @event = params[:event]
    @greeting = "Hi"
    attachments['default_logo_small.png'] = File.read('app/assests/images/default_logo_small.png')

    mail( 
      from: "herf@support.com",
      to: User.first.email, 
      cc: User.all.pluck(:email), 
      subject: "You're invited to our new event!"
    )
  end
end