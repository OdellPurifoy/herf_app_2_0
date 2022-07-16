class CreateLounges < ActiveRecord::Migration[7.0]
  def change
    create_table :lounges do |t|
      t.string :name
      t.string :address_street_1
      t.string :address_street_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.time :opening_time
      t.time :closing_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
