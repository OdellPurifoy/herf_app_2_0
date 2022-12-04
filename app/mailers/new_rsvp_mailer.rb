# frozen_string_literal: true

class NewRsvpMailer < ApplicationMailer
  def notify_user
    @rsvp = params[:rsvp]

    mail(
      from: 'herf@support.com',
      to: 'to@example.org',
      subject: 'RSVP Confirmation'
    )
  end
end
