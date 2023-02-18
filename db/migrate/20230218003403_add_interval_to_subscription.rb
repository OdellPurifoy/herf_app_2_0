# frozen_string_literal: true

class AddIntervalToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :interval, :string
  end
end
