class SyncUserToMemberJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Lets sync the member and user!"
  end
end
