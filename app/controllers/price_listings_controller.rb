class PriceListingsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  private

  def check_subscription_status
    unless current_user.subscription_active?
      redirect_to checkout_path(
        mode: 'subscription',
        line_items: 'price_1MVPexJ7HwUPnCdqrojvu2lZ',
      )
    end
  end
end
