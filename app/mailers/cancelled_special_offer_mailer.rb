# frozen_string_literal: true

class CancelledSpecialOfferMailer < ApplicationMailer
  def notify_followers
    @favoritor = params[:favoritor]
    @special_offer = params[:special_offer]

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: "#{@special_offer.special_offer_type} special offer has been cancelled"
    )
  end

  def notify_members
    @membership = params[:membership]
    @special_offer = params[:special_offer]

    mail(
      from: 'herf@support.com',
      to: @membership&.email,
      subject: "#{@special_offer.special_offer_type} special offer has been cancelled"
    )
  end
end
