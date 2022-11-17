# Preview all emails at http://localhost:3000/rails/mailers/new_special_offer
class NewSpecialOfferPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_special_offer/notify_followers_and_members
  def notify_followers
    NewSpecialOfferMailer.notify_followers
  end

  # Preview this email at http://localhost:3000/rails/mailers/new_special_offer/notify_members_only
  def notify_members_only
    NewSpecialOfferMailer.notify_members
  end
end
