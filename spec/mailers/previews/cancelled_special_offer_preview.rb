# Preview all emails at http://localhost:3000/rails/mailers/cancelled_special_offer
class CancelledSpecialOfferPreview < ActionMailer::Preview
  def special_offer
    SpecialOffer.last
  end

  def favoritor
    SpecialOffer.last.lounge.favoritors.last
  end

  # Preview this email at http://localhost:3000/rails/mailers/cancelled_special_offer/notify_followers
  def notify_followers
    CancelledSpecialOfferMailer.with(favoritor: favoritor, special_offer: special_offer).notify_followers
  end

  # Preview this email at http://localhost:3000/rails/mailers/cancelled_special_offer/notify_members
  def notify_members
    CancelledSpecialOfferMailer.with(favoritor: favoritor, special_offer: special_offer).notify_members
  end
end
