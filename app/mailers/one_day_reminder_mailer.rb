# frozen_string_literal: true

class OneDayReminderMailer < ApplicationMailer
  def remind_members
    @membership = params[:membership]
    @event = params[:event]

    mail(
      from: 'herf@support.com',
      to: @membership&.email,
      subject: "You're invited to our new event!"
    )
  end
end
