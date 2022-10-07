class AddUserToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_reference :memberships, :user, index: true
  end
end
