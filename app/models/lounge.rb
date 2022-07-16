# frozen_string_literal: true

class Lounge < ApplicationRecord
  belongs_to :user
  has_rich_text :details

  validates_presence_of :name, :address_street_1, :city, :state, :zip_code, :phone, :email
  validates :email, uniqueness: true
  validates :name, uniqueness: {
    scope: %i[address_street_1 city state zip_code],
    message: 'A lounge already exists at this location.'
  }
end
