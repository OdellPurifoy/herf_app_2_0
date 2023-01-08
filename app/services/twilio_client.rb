# frozen_string_literal: true

class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_text(phone_number, message)
    client.messages.create(
      to: phone_number,
      from: twilio_phone_number,
      body: message
    )
  rescue Twilio::REST::RestError => error
    puts "Error: #{error} prevented text from being sent."
  end

  private

  def account_sid
    Rails.application.credentials.twilio[:account_sid]
  end

  def auth_token
    Rails.application.credentials.twilio[:auth_token]
  end

  def twilio_phone_number
    '14258420884'
  end
end
