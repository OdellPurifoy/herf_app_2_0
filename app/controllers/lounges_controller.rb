# frozen_string_literal: true

class LoungesController < ApplicationController
  before_action :set_lounge, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /lounges or /lounges.json
  def index
    @lounges = Lounge.all
  end

  # GET /lounges/1 or /lounges/1.json
  def show
    # flash.now[:notice] = 'Lounge successfully created.'
  end

  # GET /lounges/new
  def new
    @lounge = current_user.lounges.build
  end

  # GET /lounges/1/edit
  def edit; end

  # POST /lounges or /lounges.json
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

  # PATCH/PUT /lounges/1 or /lounges/1.json
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

  # DELETE /lounges/1 or /lounges/1.json
  def destroy
    @lounge.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'Lounge successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lounge
    @lounge = Lounge.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lounge_params
    params.require(:lounge).permit(:name, :email, :phone, :address_street_1, :address_street_2, :city, :state, :zip_code, :details,
                                   :hours, :logo, :outside_cigars_allowed, :outside_drinks_allowed, :weekday_opening_hour, :weekday_closing_hour, 
                                   :weekend_opening_hour, :weekend_closing_hour)
  end
end
