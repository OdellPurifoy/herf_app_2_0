# Preview all emails at http://localhost:3000/rails/mailers/subscription
class SubscriptionPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/subscription/payment_failed
  def payment_failed
    SubscriptionMailer.payment_failed
  end

end
