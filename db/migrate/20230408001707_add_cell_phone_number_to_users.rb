# frozen_string_literal: true

class AddCellPhoneNumberToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_cell_phone, :string
  end
end
