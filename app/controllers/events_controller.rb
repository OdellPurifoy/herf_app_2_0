# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_lounge, only: %i[index new create]

  def index
    @events = @lounge.events
  end

  def show; end

  def new
    @event = @lounge.events.build
  end

  def edit; end

  def create
    @event = @lounge.events.build(event_params)

    respond_to do |format|
      if @event.save
        if @event.members_only?
          @event.notify_members_only
        else
          @event.notify_followers_and_members
        end
        format.turbo_stream { redirect_to event_path(@event) }
        format.html { redirect_to lounge_event_url(@event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.turbo_stream { redirect_to [@lounge, @event] }
        format.html { redirect_to lounge_event_url(@event), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'Event successfully deleted.'
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def set_lounge
    @lounge = Lounge.friendly.find(params[:lounge_id])
  end

  def event_params
    params.require(:event).permit(:name, :end_time, :event_type, :event_url, :maximum_capacity, :members_only, :rsvp_needed, :start_time, :event_date,
                                  :lounge_id, :flyer, :description)
  end
end
