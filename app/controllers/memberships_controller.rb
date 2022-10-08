class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[ show edit update destroy ]
  before_action :set_lounge, only: %i[index new create]

  def index
    @memberships = @lounge.memberships
  end

  def show
  end

  def new
    @membership = @lounge.memberships.build
  end

  def edit
  end

  def create
    @membership = @lounge.memberships.build(membership_params)

    respond_to do |format|
      if @membership.save
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully created." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url, notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def set_lounge
      @lounge = Lounge.friendly.find(params[:lounge_id])
    end

    def membership_params
      params.require(:membership).permit(:first_name, :last_name, :email, :phone_number, :lounge_id)
    end
end
