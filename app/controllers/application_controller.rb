# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_stripe_key

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username phone_number])
    devise_parameter_sanitizer.permit(:account_updated, keys: %i[first_name last_name username phone_number])
  end

  private

  def set_stripe_key
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :private_key)
  end
end
