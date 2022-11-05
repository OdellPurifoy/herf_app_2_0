# Preview all emails at http://localhost:3000/rails/mailers/new_special_offer
class NewSpecialOfferPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_special_offer/notify_followers_and_members
  def notify_followers_and_members
    NewSpecialOfferMailer.notify_followers_and_members
  end

  # Preview this email at http://localhost:3000/rails/mailers/new_special_offer/notify_members_only
  def notify_members_only
    NewSpecialOfferMailer.notify_members_only
  end

end
