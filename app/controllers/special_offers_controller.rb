# frozen_string_literal: true

class SpecialOffersController < ApplicationController
  before_action :set_special_offer, only: %i[show edit update destroy]
  before_action :set_lounge, only: %i[index new create]

  def index
    @special_offers = if params[:search].present?
                        SpecialOffer.search(params[:search])
                      else
                        @lounge.special_offers.order(:create_at)
                      end
  end

  def show; end

  def new
    @special_offer = @lounge.special_offers.build
  end

  def edit; end

  def create
    @special_offer = @lounge.special_offers.build(special_offer_params)

    respond_to do |format|
      if @special_offer.save
        format.turbo_stream { redirect_to special_offer_path(@special_offer) }
        format.html { redirect_to special_offer_url(@special_offer), notice: 'Special offer was successfully created.' }
        format.json { render :show, status: :created, location: @special_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @special_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @special_offer.update(special_offer_params)
        format.turbo_stream { redirect_to [@lounge, @special_offer] }
        format.html { redirect_to special_offer_url(@special_offer), notice: 'Special offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @special_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @special_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @special_offer.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'Special offer successfully deleted.'
  end

  private

  def set_special_offer
    @special_offer = SpecialOffer.find(params[:id])
  end

  def set_lounge
    @lounge = Lounge.friendly.find(params[:lounge_id])
  end

  def special_offer_params
    params.require(:special_offer).permit(:special_offer_type, :description, :flyer, :members_only, :start_date,
                                          :end_date, :lounge_id, :search)
  end
end
