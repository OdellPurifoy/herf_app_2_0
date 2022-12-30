# frozen_string_literal: true

class LoungesController < ApplicationController
  before_action :set_lounge, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @lounges = Lounge.all
  end

  def show; end

  def new
    @lounge = current_user.lounges.build
  end

  def edit; end

  def create
    @lounge = current_user.lounges.build(lounge_params)

    respond_to do |format|
      if @lounge.save
        format.turbo_stream { redirect_to lounge_url(@lounge) }
        flash[:notice] = 'Lounge successfully created.'
        format.html { redirect_to lounge_url(@lounge) }
        format.json { render :show, status: :created, location: @lounge }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lounge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lounge.update(lounge_params)
        format.turbo_stream { redirect_to lounge_url(@lounge) }
        flash[:notice] = 'Lounge successfully updated.'
        format.html { redirect_to lounge_url(@lounge), notice: 'Lounge was successfully updated.' }
        format.json { render :show, status: :ok, location: @lounge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lounge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lounge.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'Lounge successfully deleted.'
  end

  def toggle_favorite
    @lounge = Lounge.friendly.find(params[:id])
    current_user.favorited?(@lounge) ? current_user.unfavorite(@lounge) : current_user.favorite(@lounge)
  end

  def my_lounges
    @current_user_lounges = current_user.lounges
  end

  private

  def set_lounge
    @lounge = Lounge.friendly.find(params[:id])
  end

  def lounge_params
    params.require(:lounge).permit(:name, :email, :phone, :address_street_1, :address_street_2, :city, :state, :zip_code, :details,
                                   :hours, :logo, :outside_cigars_allowed, :outside_drinks_allowed, :weekday_opening_hour, :weekday_closing_hour,
                                   :weekend_opening_hour, :weekend_closing_hour, images: [])
  end
end
