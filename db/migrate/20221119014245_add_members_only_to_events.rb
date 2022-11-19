# frozen_string_literal: true

class AddMembersOnlyToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :members_only, :boolean, default: false
  end
end
