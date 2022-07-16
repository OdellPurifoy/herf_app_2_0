class LoungesController < ApplicationController
  before_action :set_lounge, only: %i[ show edit update destroy ]

  # GET /lounges or /lounges.json
  def index
    @lounges = Lounge.all
  end

  # GET /lounges/1 or /lounges/1.json
  def show
  end

  # GET /lounges/new
  def new
    @lounge = Lounge.new
  end

  # GET /lounges/1/edit
  def edit
  end

  # POST /lounges or /lounges.json
  def create
    @lounge = Lounge.new(lounge_params)

    respond_to do |format|
      if @lounge.save
        format.html { redirect_to lounge_url(@lounge), notice: "Lounge was successfully created." }
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
        format.html { redirect_to lounge_url(@lounge), notice: "Lounge was successfully updated." }
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

    respond_to do |format|
      format.html { redirect_to lounges_url, notice: "Lounge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lounge
      @lounge = Lounge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lounge_params
      params.require(:lounge).permit(:name, :address_street_1, :address_street_2, :city, :state, :zip_code, :details, :opening_time, :closing_time, :user_id)
    end
end
