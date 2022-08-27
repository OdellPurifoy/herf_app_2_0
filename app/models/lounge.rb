# frozen_string_literal: true

# == Schema Information
#
# Table name: lounges
#
#  id                     :bigint           not null, primary key
#  address_street_1       :string
#  address_street_2       :string
#  city                   :string
#  email                  :string
#  featured               :boolean          default(FALSE)
#  name                   :string
#  outside_cigars_allowed :boolean          default(FALSE)
#  outside_drinks_allowed :boolean          default(FALSE)
#  phone                  :string
#  slug                   :string
#  state                  :string
#  weekday_closing_hour   :string
#  weekday_opening_hour   :string
#  weekend_closing_hour   :string
#  weekend_opening_hour   :string
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
  AM_HOURS = ['Closed', '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM', '6:00 AM', '7:00 AM',
              '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM'].freeze

  PM_HOURS = ['Closed', '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM',
    '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM'].freeze
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :events, dependent: :destroy

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
