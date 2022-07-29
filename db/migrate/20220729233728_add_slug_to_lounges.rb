class AddSlugToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :slug, :string
    add_index :lounges, :slug, unique: true
  end
end
