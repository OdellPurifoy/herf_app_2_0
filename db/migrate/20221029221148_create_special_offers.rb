class CreateSpecialOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :special_offers do |t|
      t.string :type
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :lounge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
