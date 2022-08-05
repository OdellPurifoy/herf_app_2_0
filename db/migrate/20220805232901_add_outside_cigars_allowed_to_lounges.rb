class AddOutsideCigarsAllowedToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :outside_cigars_allowed, :boolean, default: false
  end
end
