# Preview all emails at http://localhost:3000/rails/mailers/update_special_offer_mailer
class UpdateSpecialOfferMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/update_special_offer_mailer/notify_followers
  def notify_followers
    UpdateSpecialOfferMailer.notify_followers
  end

  # Preview this email at http://localhost:3000/rails/mailers/update_special_offer_mailer/notify_members
  def notify_members
    UpdateSpecialOfferMailer.notify_members
  end

end
