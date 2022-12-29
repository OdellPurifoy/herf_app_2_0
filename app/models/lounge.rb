# frozen_string_literal: true

# == Schema Information
#
# Table name: lounges
#
#  id                     :bigint           not null, primary key
#  address_street_1       :string
#  address_street_2       :string
#  city                   :string
#  details                :text
#  email                  :string
#  featured               :boolean          default(FALSE)
#  name                   :string
#  outside_cigars_allowed :boolean          default(FALSE)
#  outside_drinks_allowed :boolean          default(FALSE)
#  phone                  :string
#  slug                   :string
#  state                  :string
#  time_zone              :string
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
  extend FriendlyId
  friendly_id :name, use: :slugged

  AM_HOURS_DISPLAY = ['Closed', '12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM', '6:00 AM', '7:00 AM',
                      '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM'].freeze

  PM_HOURS_DISPLAY = ['Closed', '12:00 PM', '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM',
                      '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM', '12:00 PM'].freeze

  TIME_ZONES = ['Eastern Time', 'Central Time', 'Mountain Time', 'Pacific Time', 'Alaska Time',
                'Hawaii-Aleutian Time'].freeze

  belongs_to :user

  has_many :events, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :special_offers, dependent: :destroy

  has_rich_text :details
  has_one_attached :logo

  validates_presence_of :name, :address_street_1, :city, :state, :zip_code, :phone, :email
  validates :email, uniqueness: true
  validates :email,
            format: { with: /\A^(.+)@(.+)$\z/, message: 'Email invalid' },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }

  validates :name, uniqueness: {
    scope: %i[address_street_1 city state zip_code],
    message: 'A lounge already exists at this location.'
  }
  validates :details, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed." }

  validates_format_of :zip_code,
                    :with => /\A\d{5}-\d{4}|\A\d{5}\z/,
                    :message => "should be 12345 or 12345-1234"

  validates :logo, file_size: { less_than_or_equal_to: 5.megabytes },
                   file_content_type: { allow: ['image/jpeg', 'image/png'] }

  scope :featured, -> { where(featured: true) }

  acts_as_favoritable
end
