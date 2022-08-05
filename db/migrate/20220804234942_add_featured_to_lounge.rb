class AddFeaturedToLounge < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :featured, :boolean, default: false
  end
end
