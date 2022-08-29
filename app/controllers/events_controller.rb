class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :set_lounge

  # GET /events or /events.json
  def index
    @events = @lounge.events
  end

  # GET /events/1 or /events/1.json
  def show
  end 

  # GET /events/new
  def new
    @event = @lounge.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = @lounge.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.turbo_stream { redirect_to [@lounge, @event] }
        format.html { redirect_to lounge_event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.turbo_stream { redirect_to [@lounge, @event] }
        format.html { redirect_to lounge_event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
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

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :event_type, :start_time_display, 
        :end_time_display, :maximum_capacity, :rsvp_needed, :event_date, 
        :lounge_id, :flyer, :description)
    end
end
