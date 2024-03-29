# Preview all emails at http://localhost:3000/rails/mailers/update_special_offer_mailer
class UpdateSpecialOfferMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/update_special_offer_mailer/notify_followers
  def notify_followers
    UpdateSpecialOfferMailer.with(favoritor: favoritor, special_offer: special_offer).notify_followers
  end

  # Preview this email at http://localhost:3000/rails/mailers/update_special_offer_mailer/notify_members
  def notify_members
    UpdateSpecialOfferMailer.with(membership: membership, special_offer: special_offer).notify_members
  end

  private

  def special_offer
    SpecialOffer.last
  end

  def favoritor
    SpecialOffer.last.lounge.favoritors.last
  end

  def membership
    SpecialOffer.last.lounge.memberships.last
  end
end
