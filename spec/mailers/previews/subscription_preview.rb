# frozen_string_literal: true

class SubscriptionPreview < ActionMailer::Preview
  def payment_failed
    SubscriptionMailer.with(user: User.last).payment_failed
  end
end
