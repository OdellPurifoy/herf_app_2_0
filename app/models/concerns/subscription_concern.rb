# frozen_string_literal: true

module SubcriptionConern
  extends ActiveSupport::Concern

  included do
    def check_subscription_status
      subscription = payment_processor&.subscription&.processor_subscription

      return if subscription.nil?

      update(subscription_status: subscription.status, subscription_end_date: Time.at(subscription.current_period_end),
             subscription__start_date: Time.at(subscription.current_period_start))
    end

    def subscription_active?
      check_subscription_status if subscription_end_date.nil? || subscription_end_date < Time.now

      subscription.nil? ? false : subscription_end_date > Time.now
    end
  end
end
