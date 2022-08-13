class AddWeekDayHoursToLounges < ActiveRecord::Migration[7.0]
  def change
    add_column :lounges, :weekday_opening_hour, :string
    add_column :lounges, :weekday_closing_hour, :string
    add_column :lounges, :weekend_opening_hour, :string
    add_column :lounges, :weekend_closing_hour, :string
  end
end
