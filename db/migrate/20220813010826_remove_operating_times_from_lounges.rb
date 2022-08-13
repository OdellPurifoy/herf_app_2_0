class RemoveOperatingTimesFromLounges < ActiveRecord::Migration[7.0]
  def change
    remove_column :lounges, :opening_time, :time
    remove_column :lounges, :closing_time, :time
  end
end
