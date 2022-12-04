# frozen_string_literal: true

class CreateRsvps < ActiveRecord::Migration[7.0]
  def change
    create_table :rsvps do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
