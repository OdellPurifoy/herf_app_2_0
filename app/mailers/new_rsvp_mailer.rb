# frozen_string_literal: true

class NewRsvpMailer < ApplicationMailer
  def notify_user
    @rsvp = params[:rsvp]

    mail(
      from: 'herf@support.com',
      to: @rsvp.user.email,
      subject: 'RSVP Confirmation'
    )
  end
end
