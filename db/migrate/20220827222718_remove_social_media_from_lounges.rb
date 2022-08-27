class RemoveSocialMediaFromLounges < ActiveRecord::Migration[7.0]
  def change
    remove_column :lounges, :instagram_handle, :string
    remove_column :lounges, :twitter_handle, :string
    remove_column :lounges, :tiktok_handle, :string
  end
end
