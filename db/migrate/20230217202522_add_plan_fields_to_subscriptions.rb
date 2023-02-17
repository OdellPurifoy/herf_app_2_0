# frozen_string_literal: true

class AddPlanFieldsToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :plan_interval, :string
    add_column :subscriptions, :subscription_id, :string
  end
end
