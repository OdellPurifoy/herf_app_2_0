# Preview all emails at http://localhost:3000/rails/mailers/update_special_offer_mailer
class UpdateSpecialOfferMailerPreview < ActionMailer::Preview
  def special_offer
    SpecialOffer.last
  end

  # Preview this email at http://localhost:3000/rails/mailers/update_special_offer_mailer/notify_followers
  def notify_followers
    UpdateSpecialOfferMailer.with(special_offer: special_offer).notify_followers
  end

  # Preview this email at http://localhost:3000/rails/mailers/update_special_offer_mailer/notify_members
  def notify_members
    UpdateSpecialOfferMailer.with(special_offer: special_offer).notify_members
  end
end
