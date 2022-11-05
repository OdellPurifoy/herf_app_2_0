# frozen_string_literal: true

class NewSpecialOfferMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_special_offer_mailer.notify_followers_and_members.subject
  #
  def notify_followers
    @favoritor = params[:favoritor]
    @special_offer = params[:special_offer]

    mail to: 'to@example.org'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_special_offer_mailer.notify_members_only.subject
  #
  def notify_members
    @membership = params[:membership]
    @special_offer = params[:special_offer]

    mail to: 'to@example.org'
  end
end
