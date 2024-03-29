# frozen_string_literal: true

class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]
  before_action :set_lounge, only: %i[index new create]

  def index
    @memberships = if params[:search].present?
                     Membership.search(params[:search])
                   else
                     @lounge.memberships.order(:created_at).page(params[:page])
                   end
  end

  def show; end

  def new
    @membership = @lounge.memberships.build
    authorize @membership
  end

  def edit; end

  def create
    @membership = @lounge.memberships.build(membership_params)

    # Pundit check
    authorize @membership

    respond_to do |format|
      if @membership.save
        format.html { redirect_to membership_url(@membership), notice: 'Membership was successfully created.' }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      # Pundit check
      authorize @membership

      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lounge = @membership.lounge

    # Pundit check
    authorize @membership

    @membership.destroy
    redirect_to "/lounges/#{@lounge.friendly_id}/memberships", status: :see_other
    flash[:notice] = 'Membership successfully deleted.'
  end

  def activate
    @membership = Membership.find(params[:id])
    @lounge = @membership.lounge
    @membership.update!(active: true)
    redirect_to lounge_memberships_path(@lounge)
    flash[:notice] = 'Membership activated'
  end

  def deactivate
    @membership = Membership.find(params[:id])
    @lounge = @membership.lounge
    @membership.update!(active: false)
    redirect_to lounge_memberships_path(@lounge)
    flash[:notice] = 'Membership deactivated'
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def set_lounge
    @lounge = Lounge.friendly.find(params[:lounge_id])
  end

  def membership_params
    params.require(:membership).permit(:active, :first_name, :last_name, :email, :phone_number, :lounge_id, :search)
  end
end
