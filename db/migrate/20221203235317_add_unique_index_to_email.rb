# frozen_string_literal: true

class AddUniqueIndexToEmail < ActiveRecord::Migration[7.0]
  def change
    add_index :rsvps, :email, unique: true
  end
end
