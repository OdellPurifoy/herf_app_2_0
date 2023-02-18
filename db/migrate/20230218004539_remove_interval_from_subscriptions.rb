# frozen_string_literal: true

class RemoveIntervalFromSubscriptions < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :interval, :string
  end
end
