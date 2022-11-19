# frozen_string_literal: true

class NotifyFollowersMailer < ApplicationMailer
  def notify_followers
    @favoritor = params[:favoritor]
    @event = params[:event]
    # @greeting = "Hi"
    # attachments['default_logo_small.png'] = File.read('app/assests/images/default_logo_small.png')

    mail(
      from: 'herf@support.com',
      to: @favoritor&.email,
      subject: "You're invited to our new event!"
    )
  end

  def notify_members
    @membership = params[:membership]
    @event = params[:event]
    # @greeting = "Hi"
    # attachments['default_logo_small.png'] = File.read('app/assests/images/default_logo_small.png')

    mail(
      from: 'herf@support.com',
      to: @membership.email,
      subject: "You're invited to our new event!"
    )
  end
end
