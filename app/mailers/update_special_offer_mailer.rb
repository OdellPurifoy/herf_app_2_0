# frozen_string_literal: true

class UpdateSpecialOfferMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_special_offer_mailer.notify_followers.subject
  #
  def notify_followers
    @favoritor = params[:favoritor]
    @special_offer = params[:special_offer]

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: "Update for our #{@special_offer.name} special offer"
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.update_special_offer_mailer.notify_members.subject
  #
  def notify_members
    @membership = params[:membership]
    @special_offer = params[:special_offer]
  
    mail(
      from: 'herf@support.com',
      to: @membership&.email,
      subject: "Update for our #{@special_offer.name} special offer"
    )
  end
end
