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
      return if !User.exists?(event.data.object.client_reference_id)

      fullfill_order(event.data.object)
    when 'checkout.session.async_payment_succeeded'
    when 'invoice.payment_succeeded'
    when 'invoice.payment_failed'
    when 'customer.subscription.updated'
    else
      puts "Unhandled event type: #{event.type}"
    end

    render json: { message: 'success'}
  end

  private 

  def fullfill_order(checkout_session)
    user = User.find(checkout_session.client_reference_id)
    user.update(customer_id: checkout_session.customer)

    stripe_subscription = Stripe::Subscription.retrieve(checkout_session.subscription)

    Subscription.create!(
      customer_id: stripe_subscription.customer, 
      current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime, 
      current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
      plan: stripe_subscription.plan.id,
      plan_interval: stripe_subscription.plan.interval,
      status: stripe_subscription.status,
      subscription_id: stripe_subscription.id,
      user: user
    )
  end
end
