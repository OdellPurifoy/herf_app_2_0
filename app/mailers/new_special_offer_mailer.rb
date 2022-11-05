class NewSpecialOfferMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_special_offer_mailer.notify_followers_and_members.subject
  #
  def notify_followers_and_members
    @favoritor = params[:favoritor]
    @member = params[:member]
    @event = params[:event]

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_special_offer_mailer.notify_members_only.subject
  #
  def notify_members_only
    @member = params[:member]

    mail to: "to@example.org"
  end
end
