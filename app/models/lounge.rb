# frozen_string_literal: true

# == Schema Information
#
# Table name: lounges
#
#  id                     :bigint           not null, primary key
#  address_street_1       :string
#  address_street_2       :string
#  city                   :string
#  closing_time           :time
#  email                  :string
#  featured               :boolean          default(FALSE)
#  hours                  :string
#  name                   :string
#  opening_time           :time
#  outside_cigars_allowed :boolean          default(FALSE)
#  outside_drinks_allowed :boolean          default(FALSE)
#  phone                  :string
#  slug                   :string
#  state                  :string
#  zip_code               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_lounges_on_slug     (slug) UNIQUE
#  index_lounges_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Lounge < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_rich_text :details
  has_one_attached :logo

  validates_presence_of :name, :address_street_1, :city, :state, :zip_code, :phone, :email
  validates :email, uniqueness: true
  validates :name, uniqueness: {
    scope: %i[address_street_1 city state zip_code],
    message: 'A lounge already exists at this location.'
  }
  
  validates :logo, file_size: { less_than_or_equal_to: 5.megabytes },
                     file_content_type: { allow: ['image/jpeg', 'image/png'] }

  scope :featured, -> { where(featured: true) }
end
