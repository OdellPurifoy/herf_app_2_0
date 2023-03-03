# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: %i[show edit update destroy]

  def index
    @current_user_notifications = current_user.notifications
  end

  def show; end

  def new
    @notification = Notification.new
  end

  def edit; end

  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to notification_url(@notification), notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to notification_url(@notification), notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification.destroy

    redirect_to root_path, status: :see_other
    flash[:notice] = 'Notification offer successfully deleted.'
  end

  def read
    @notification = Notification.find(params[:id])
    @notification.update!(read: true)
    redirect_to notifications_path(@notification)
  end

  def unread
    @notification = Notification.find(params[:id])
    @notification.update!(read: false)
    redirect_to notifications_path(@notification)
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(:body, :read, :user_id)
  end
end