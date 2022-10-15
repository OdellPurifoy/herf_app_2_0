class SyncUserToMemberJob < ApplicationJob
  queue_as :default

  def perform(user)
    memberships = Membership.where(email: user.email)
    return "Membership not found" if memberships.nil?

    memberships.each do |membership|
      membership.user_id = user.id
      membership.save!
    end   
  end
end
