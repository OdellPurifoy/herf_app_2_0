class RemoveHoursFromLounges < ActiveRecord::Migration[7.0]
  def change
    remove_column :lounges, :hours, :string
  end
end
