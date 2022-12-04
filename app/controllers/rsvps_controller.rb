# frozen_string_literal: true

class RsvpsController < ApplicationController
  before_action :set_rsvp, only: %i[show edit update destroy]
  before_action :set_event, only: %i[index new create]

  def index
    @rsvps = @event.rsvps
  end

  def show; end

  def new
    @rsvp = @event.rsvps.build
  end

  def edit; end

  def create
    @rsvp = @event.rsvps.build(rsvp_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @rsvp.save
        format.turbo_stream { redirect_to rsvp_path(@rsvp) }
        format.html { redirect_to rsvp_url(@rsvp), notice: 'Rsvp was successfully created.' }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rsvp.update(rsvp_params)
        format.html { redirect_to rsvp_url(@rsvp), notice: 'Rsvp was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsvp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rsvp.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'RSVP successfully deleted.'
  end

  private

  def set_rsvp
    @rsvp = Rsvp.find(params[:id])
  end

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def rsvp_params
    params.require(:rsvp).permit(:first_name, :last_name, :phone_number, :number_of_guests, :email)
  end
end
