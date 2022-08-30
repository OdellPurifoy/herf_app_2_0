# frozen_string_literal: true

class AddStartAndEndTimeToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
  end
end
