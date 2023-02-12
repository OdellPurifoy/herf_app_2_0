# frozen_string_literal: true

class RemoveSubscriptionFieldsFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :subscription_end_date
    remove_column :users, :subscription_start_date
    remove_column :users, :subscription_status
  end
end
