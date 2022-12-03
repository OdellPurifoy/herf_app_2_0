# frozen_string_literal: true

class AddNumberOfGuestsToRsvps < ActiveRecord::Migration[7.0]
  def change
    add_column :number_of_guests, :rsvps, :integer
  end
end
