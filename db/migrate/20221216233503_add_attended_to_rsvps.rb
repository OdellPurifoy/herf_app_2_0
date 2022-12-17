# frozen_string_literal: true

class AddAttendedToRsvps < ActiveRecord::Migration[7.0]
  def change
    add_column :rsvps, :attended, :boolean, default: false
  end
end
