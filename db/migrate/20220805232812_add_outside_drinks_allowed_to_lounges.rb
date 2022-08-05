class AddOutsideDrinksAllowedToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :outside_drinks_allowed, :boolean, default: false
  end
end
