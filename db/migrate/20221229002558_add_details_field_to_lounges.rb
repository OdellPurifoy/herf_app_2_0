class AddDetailsFieldToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :details, :text
  end
end
