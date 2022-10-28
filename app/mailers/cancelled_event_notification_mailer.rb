class CancelledEventNotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelled_event_notification_mailer.cancel_notify_followers.subject
  #
  def cancel_notify_followers
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
