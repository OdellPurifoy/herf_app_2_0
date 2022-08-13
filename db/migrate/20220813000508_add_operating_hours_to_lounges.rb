class AddOperatingHoursToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :opening_time, :time
    add_column :lounges, :closing_time, :time
  end
end
