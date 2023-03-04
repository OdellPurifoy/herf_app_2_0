# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # docs: https://stripe.com/docs/payments/checkout/fulfill-orders
    # receive POST from Stripe
    payload = request.body.read
    signature_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :signing_secret)
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, signature_header, endpoint_secret.to_s)
    rescue JSON::ParserError => e
      # Invalid payload
      puts "JSON Parse error: #{e}"
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Stripe Signature Verification Error: #{e}"
      return
    end

    case event.type
    when 'checkout.session.completed'
      return unless User.exists?(event.data.object.client_reference_id)

      fullfill_order(event.data.object)
    when 'invoice.payment_succeeded'
      # return if a subscription id isn't present on the invoice
      return unless event.data.object.subscription.present?

      # Continue to provision subscription as payments continue to be made.
      # Store the status in the DB and check when a user accesses Herf.
      stripe_subscription = Stripe::Subscription.retrieve(event.data.object.subscription)
      subscription = Subscription.find_by(subscription_id: stripe_subscription)

      subscription.update(
        current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
        current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
        plan_id: stripe_subscription.plan.id,
        plan_interval: stripe_subscription.plan.interval,
        status: stripe_subscription.status
      )
    when 'invoice.payment_failed'
      # Find the user by stripe id or customer id from Stripe event response
      user = User.find_by(customer_id: event.data.object.customer)

      if user.exists?
        SubscriptionMailer.with(user: user).payment_failed.deliver_now
      else
        puts "Unhandled event type: #{event.type}"
      end
    when 'customer.subscription.updated'
      # Target subscription to delete
      stripe_subscription = event.data.object

      if stripe_subscription.cancel_at_period_end == true
        subscription = Subscription.find_by(subscription_id: stripe_subscription.id)

        if subscription.present?
          subscription.update(
            current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
            current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
            plan_id: stripe_subscription.plan.id,
            plan_interval: stripe_subscription.plan.interval,
            status: stripe_subscription.status
          )
        end
      end
    else
      puts "Unhandled event type: #{event.type}"
    end
    puts 'Success'
  end

  private

  def fullfill_order(checkout_session)
    # Find user and assign customer_id
    user = User.find(checkout_session.client_reference_id)
    user.update(customer_id: checkout_session.customer)

    # Retrieve new subscription via Stripe API using subscription_id
    stripe_subscription = Stripe::Subscription.retrieve(checkout_session.subscription)

    # Create new subscription with Stripe subscription details and user data
    Subscription.create(
      customer_id: stripe_subscription.customer,
      current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
      current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
      plan_id: stripe_subscription.plan.id,
      plan_interval: stripe_subscription.plan.interval,
      status: stripe_subscription.status,
      subscription_id: stripe_subscription.id,
      user_id: user.id
    )
  end
end
