# frozen_string_literal: true

class AddNumberOfGuestsToRsvps < ActiveRecord::Migration[7.0]
  def change
    add_column :rsvps, :number_of_guests, :integer
  end
end
