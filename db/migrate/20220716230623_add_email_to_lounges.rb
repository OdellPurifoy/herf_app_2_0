class AddEmailToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :email, :string
  end
end
