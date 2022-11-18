# frozen_string_literal: true

class CancelledEventNotificationMailer < ApplicationMailer
  def cancel_notify_followers
    @favoritor = params[:favoritor]
    @event = params[:event]
    # @greeting = "Hi"
    # attachments['default_logo_small.png'] = File.read('app/assests/images/default_logo_small.png')

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: 'Event cancelled'
    )
  end
end
