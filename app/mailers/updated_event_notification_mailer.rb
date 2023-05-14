# frozen_string_literal: true

class UpdatedEventNotificationMailer < ApplicationMailer
  def update_notify_followers
    @favoritor = params[:favoritor]
    @event = params[:event]

    mail(
      from: 'herf@support.com',
      to: @favoritor.email,
      subject: 'Upcoming event has been updated'
    )
  end

  def update_notify_members
    @membership = params[:membership]
    @event = params[:event]

    mail(
      from: 'herf@support.com',
      to: @membership.email,
      subject: 'Upcoming event has been updated'
    )
  end
end
