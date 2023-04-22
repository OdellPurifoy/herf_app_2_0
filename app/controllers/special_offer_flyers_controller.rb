class SpecialOfferFlyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_special_offer

  def destroy
    @special_offer.flyer.purge_later

    respond_to do |format|
      format.html { redirect_to edit_special_offer_path(@special_offer) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@special_offer, :flyer))}
    end
  end

  private

  def set_special_offer
    @special_offer = SpecialOffer.find(params[:special_offer_id])
  end
end