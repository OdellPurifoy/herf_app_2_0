class RemoveLoungeMembershipsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :lounge_memberships
  end
end
