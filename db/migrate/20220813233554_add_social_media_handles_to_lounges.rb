class AddSocialMediaHandlesToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :instagram_handle, :string, unique: true
    add_column :lounges, :twitter_handle, :string, unique: true
    add_column :lounges, :tiktok_handle, :string, unique: true
  end
end
