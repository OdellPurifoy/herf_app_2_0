class CancelledSpecialOfferMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelled_special_offer_mailer.notify_followers.subject
  #
  def notify_followers
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cancelled_special_offer_mailer.notify_members.subject
  #
  def notify_members
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
