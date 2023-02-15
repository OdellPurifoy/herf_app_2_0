class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    signature_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :signing_secret)
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, signature_header, endpoint_secret)
    rescue JSON::ParseError => e
      render json: { message: e }, status: 400
    rescue Stripe::SignatureVerificationError => e
      render json: { message: e }, status: 400
      return
    end

    case event.type
    when 'checkout.session.completed'
      client_reference_id = event.data.object.client_reference_id.to_i
      return if !User.exists?(client_reference_id)
      
      @user = User.find(client_reference_id)
    when 'checkout.session.async_payment_succeeded'
    when 'invoice.payment_succeeded'
    when 'invoice.payment_failed'
    when 'customer.subscription.updated'
    else
      puts "Unhandled event type: #{event.type}"
    end

    render json: { message: 'success'}
  end
end
