# frozen_string_literal: true

class RemoveEventTimeDisplayFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :start_time_display, :string
    remove_column :events, :end_time_display, :string
  end
end
