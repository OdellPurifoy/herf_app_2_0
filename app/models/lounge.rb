class Lounge < ApplicationRecord
  belongs_to :user
  has_rich_text :details

  validates_presence_of :name, :address_street_1, :city, :state, :zip_code
end
