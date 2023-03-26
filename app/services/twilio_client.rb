# frozen_string_literal: true

class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_text(phone_number, message, event)
    send_attemps ||= 1

    client.messages.create(
      to: phone_number,
      from: twilio_phone_number,
      body: message
    )
  rescue StandardError => e
    puts "Error: #{e} prevented text from being sent."

    if (send_attemps += 1) > 2
      puts 'retrying...'
      retry
    end

    puts '----------------------'
    puts 'Retry attempts exceeded. Creating Notification.'

    Notification.create!(
      body: "Phone number #{phone_number} could not be contacted. Please verify the number and contact the member manually.", user_id: event.lounge.user_id
    )
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
