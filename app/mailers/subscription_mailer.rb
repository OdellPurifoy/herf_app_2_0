class SubscriptionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription_mailer.payment_failed.subject
  #
  def payment_failed
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
