# frozen_string_literal: true

class StripePaymentService
  def initialize(payload, signature_header, endpoint_secret)
    @payload = payload
    @signature_header = signature_header
    @endpoint_secret = endpoint_secret
    @event = nil
  end

  def call
    stripe_transaction
  end

  private

  def stripe_transaction
    begin
      @event = Stripe::Webhook.construct_event(@payload, @signature_header, @endpoint_secret)
    rescue JSON::ParseError => e
      puts "JSON Parse error: #{e}"
    rescue Stripe::SignatureVerificationError => e
      puts "Stripe Signature Verification Error: #{e}"
      return
    end

    case @event.type
    when 'checkout.session.completed'
      return unless User.exists?(@event.data.object.client_reference_id)

      fullfill_order(@event.data.object)
    when 'invoice.payment_succeeded'
      return unless @event.data.object.subscription.present?

      stripe_subscription = Stripe::Subscription.retrieve(@event.data.object.subscription)

      subscription = Subscription.find_by(subscription_id: stripe_subscription)

      subscription.update(
        current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
        current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
        plan_id: stripe_subscription.plan.id,
        plan_interval: stripe_subscription.plan.interval,
        status: stripe_subscription.status
      )
    when 'invoice.payment_failed'
      user = User.find_by(customer_id: @event.data.object.customer)
      SubscriptionMailer.with(user: user).payment_failed.deliver_now if user.exists?
    when 'customer.subscription.updated'
      stripe_subscription = @event.data.object

      if stripe_subscription.cancel_at_period_end == true
        subscription = Subscription.find_by(subscription_id: stripe_subscription.id)

        if subscription.present?
          subscription.update(
            current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
            current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
            plan_id: stripe_subscription.plan.id,
            interval: stripe_subscription.plan.interval,
            status: stripe_subscription.status
          )
        end
      end
    else
      puts "Unhandled event type: #{@event.type}"
    end
    puts 'Success'
  end

  def fullfill_order(checkout_session)
    user = User.find(checkout_session.client_reference_id)
    user.update(customer_id: checkout_session.customer)

    stripe_subscription = Stripe::Subscription.retrieve(checkout_session.subscription)

    Subscription.create!(
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
