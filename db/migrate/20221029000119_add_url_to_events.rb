# frozen_string_literal: true

class AddUrlToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_url, :string
  end
end
