# frozen_string_literal: true

class AddDescriptionToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_description, :text
  end
end
