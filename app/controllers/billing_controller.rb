# frozen_string_literal: true

class BillingController < ApplicationController
  before_action :authenticate_user!

  def show
    session = Stripe::BillingPortal::Session.create({
      customer: current_user&.subscriptions&.last&.customer_id,
      return_url: root_url
    })

    redirect_to session.url, allow_other_host: true
  end
end