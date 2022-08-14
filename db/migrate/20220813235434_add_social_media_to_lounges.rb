class AddSocialMediaToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :instagram_handle, :string
    add_column :lounges, :twitter_handle, :string
    add_column :lounges, :tiktok_handle, :string
  end
end
