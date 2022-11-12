# Preview all emails at http://localhost:3000/rails/mailers/cancelled_special_offer
class CancelledSpecialOfferPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/cancelled_special_offer/notify_followers
  def notify_followers
    CancelledSpecialOfferMailer.notify_followers
  end

  # Preview this email at http://localhost:3000/rails/mailers/cancelled_special_offer/notify_members
  def notify_members
    CancelledSpecialOfferMailer.notify_members
  end

end
