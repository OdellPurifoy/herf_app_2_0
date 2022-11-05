# frozen_string_literal: true

class AddMembersOnlyToSpecialOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :special_offers, :members_only, :boolean, default: false
  end
end
