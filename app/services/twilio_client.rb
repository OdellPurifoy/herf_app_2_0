# frozen_string_literal: true

class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_text(user, message)
    client.messages.create(
      to: user.phone_number,
      from: phone_number,
      body: message
    )
  end

  def send_new_event_text(member_phone_number, message)
    client.messages.create(
      to: member_phone_number,
      from: phone_number,
      body: message
    )
  end

  private

  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end

  def auth_token
    Rails.application.credentials.twilio[:auth_token]
  end

  def phone_number
    '14258420884'
  end
end
