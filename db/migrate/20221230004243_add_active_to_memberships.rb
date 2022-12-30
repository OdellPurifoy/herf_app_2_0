# frozen_string_literal: true

class AddActiveToMemberships < ActiveRecord::Migration[7.0]
  def change
    add_column :memberships, :active, :boolean, default: true
  end
end
