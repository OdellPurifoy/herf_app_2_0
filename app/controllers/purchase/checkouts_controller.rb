# frozen_string_literal: true

module Purchase
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def create_monthly_email_checkout_session
      session = Stripe::Checkout::Session.create({
                                                   line_items: [{
                                                     price: 'price_1N7PkIJ7HwUPnCdq49wDuerY',
                                                     quantity: 1
                                                   }],
                                                   mode: 'subscription',
                                                   success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
                                                   cancel_url: 'http://localhost:3000'
                                                 })

      redirect_to session.url, allow_other_host: true, status: 303
    end

    def create_yearly_email_checkout_session
      session = Stripe::Checkout::Session.create({
                                                   line_items: [{
                                                     price: 'price_1N7PkIJ7HwUPnCdqoXFdy8H8',
                                                     quantity: 1
                                                   }],
                                                   mode: 'subscription',
                                                   success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
                                                   cancel_url: 'http://localhost:3000'
                                                 })

      redirect_to session.url, allow_other_host: true, status: 303
    end

    def create_monthly_email_and_text_checkout_session
      session = Stripe::Checkout::Session.create({
                                                   line_items: [{
                                                     price: 'price_1N7SNXJ7HwUPnCdqNhZF2sRL',
                                                     quantity: 1
                                                   }],
                                                   mode: 'subscription',
                                                   success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
                                                   cancel_url: 'http://localhost:3000'
                                                 })

      redirect_to session.url, allow_other_host: true, status: 303
    end

    def create_yearly_email_and_text_checkout_session
      session = Stripe::Checkout::Session.create({
                                                   line_items: [{
                                                     price: 'price_1N7SNXJ7HwUPnCdq0SIZhzQ4',
                                                     quantity: 1
                                                   }],
                                                   mode: 'subscription',
                                                   success_url: 'http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}',
                                                   cancel_url: 'http://localhost:3000'
                                                 })

      redirect_to session.url, allow_other_host: true, status: 303
    end

    def success
      session = Stripe::Checkout::Session.retrieve(params[:session_id])

      if session.payment_status == 'paid'
        stripe_subscription = Stripe::Subscription.retrieve(session.subscription)

        Subscription.create!(
          customer_id: session.customer,
          current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
          current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
          plan_id: stripe_subscription.plan.id,
          plan_interval: stripe_subscription.plan.interval,
          status: stripe_subscription.status,
          subscription_id: stripe_subscription.id,
          user_id: current_user.id
        )
      else
        redirect_to root_path, status: :see_other
        flash[:notice] = 'Could not create subscription.'
      end
    end
  end
end
