class LoungeMembershipsController < ApplicationController
  before_action :set_lounge_membership, only: %i[ show edit update destroy ]

  # GET /lounge_memberships or /lounge_memberships.json
  def index
    @lounge_memberships = LoungeMembership.all
  end

  # GET /lounge_memberships/1 or /lounge_memberships/1.json
  def show
  end

  # GET /lounge_memberships/new
  def new
    @lounge_membership = LoungeMembership.new
  end

  # GET /lounge_memberships/1/edit
  def edit
  end

  # POST /lounge_memberships or /lounge_memberships.json
  def create
    @lounge_membership = LoungeMembership.new(lounge_membership_params)

    respond_to do |format|
      if @lounge_membership.save
        format.html { redirect_to lounge_membership_url(@lounge_membership), notice: "Lounge membership was successfully created." }
        format.json { render :show, status: :created, location: @lounge_membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lounge_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lounge_memberships/1 or /lounge_memberships/1.json
  def update
    respond_to do |format|
      if @lounge_membership.update(lounge_membership_params)
        format.html { redirect_to lounge_membership_url(@lounge_membership), notice: "Lounge membership was successfully updated." }
        format.json { render :show, status: :ok, location: @lounge_membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lounge_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lounge_memberships/1 or /lounge_memberships/1.json
  def destroy
    @lounge_membership.destroy

    respond_to do |format|
      format.html { redirect_to lounge_memberships_url, notice: "Lounge membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lounge_membership
      @lounge_membership = LoungeMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lounge_membership_params
      params.require(:lounge_membership).permit(:first_name, :last_name, :email, :phone_number, :lounge_id)
    end
end
