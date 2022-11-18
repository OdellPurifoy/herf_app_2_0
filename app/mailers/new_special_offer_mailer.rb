# frozen_string_literal: true

class NewSpecialOfferMailer < ApplicationMailer
  def notify_followers
    @favoritor = params[:favoritor]
    @special_offer = params[:special_offer]

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: "New Special Offer!"
    )
  end

  def notify_members
    @membership = params[:membership]
    @special_offer = params[:special_offer]

    mail(
      from: 'herf@support.com',
      to: @membership&.email,
      subject: "New Special Offer!"
    )
  end
end
