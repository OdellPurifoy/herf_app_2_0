class AddPhoneToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :phone, :string
  end
end
