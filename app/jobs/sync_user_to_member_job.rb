class SyncUserToMemberJob < ApplicationJob
  queue_as :default

  def perform(user)
    membership = Membership.where(email: user.email).first
    return "Membership not found" if membership.nil?
    
    membership.user_id = user.id
    membership.save!
  end
end
