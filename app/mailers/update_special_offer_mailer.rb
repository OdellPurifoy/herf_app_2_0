# frozen_string_literal: true

class UpdateSpecialOfferMailer < ApplicationMailer
  def notify_followers
    @favoritor = params[:favoritor]
    @special_offer = params[:special_offer]

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: "Update for our #{@special_offer.special_offer_type} special offer"
    )
  end

  def notify_members
    @membership = params[:membership]
    @special_offer = params[:special_offer]
  
    mail(
      from: 'herf@support.com',
      to: @membership&.email,
      subject: "Update for our #{@special_offer.special_offer_type} special offer"
    )
  end
end
