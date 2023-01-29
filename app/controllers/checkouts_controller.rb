# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

    @checkout_session = current_user
                        .payment_processor
                        .checkout_session(
                          mode: 'payment',
                          line_items: 'price_1MVPOeJ7HwUPnCdqF88d3REB',
                          success_url: checkout_success_url
                        )
  end

  def success; end
end
