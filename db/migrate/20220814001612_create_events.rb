# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :event_type, null: false
      t.string :start_time_display
      t.string :end_time_display
      t.integer :maximum_capacity
      t.boolean :rsvp_needed, default: false
      t.date :event_date
      t.references :lounge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
