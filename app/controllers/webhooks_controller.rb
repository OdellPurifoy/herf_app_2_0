# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    StripePaymentService.new(
      request.body.read,
      request.env['HTTP_STRIPE_SIGNATURE'],
      Rails.application.credentials.dig(:stripe, :signing_secret)
    ).call
  end
end
