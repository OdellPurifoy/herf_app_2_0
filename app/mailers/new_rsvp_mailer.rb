class NewRsvpMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_rsvp_mailer.notify_user.subject
  #
  def notify_user
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
