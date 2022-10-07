class CreateLoungeMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :lounge_memberships do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.references :lounge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
