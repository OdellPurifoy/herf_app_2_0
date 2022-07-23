# frozen_string_literal: true

class AddHoursToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :hours, :string
  end
end
