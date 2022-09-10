class AddTimeZoneOptionsToLounge < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :time_zone, :string
  end
end
