class RenameTypeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :special_offers, :type, :special_offer_type
  end
end
