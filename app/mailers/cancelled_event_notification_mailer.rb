class CancelledEventNotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelled_event_notification_mailer.cancel_notify_followers.subject
  #
  def cancel_notify_followers
    @favoritor = params[:favoritor]
    @event = params[:event]
    # @greeting = "Hi"
    # attachments['default_logo_small.png'] = File.read('app/assests/images/default_logo_small.png')

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: "Event cancelled"
    )
  end
end
