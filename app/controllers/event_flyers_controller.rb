# frozen_string_literal: true

class EventFlyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def destroy
    @event.flyer.purge_later

    respond_to do |format|
      format.html { redirect_to edit_event_path(@event) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@event, :flyer)) }
    end
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end
end
