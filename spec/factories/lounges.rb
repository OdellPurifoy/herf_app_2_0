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
#  hours                  :string
#  name                   :string
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
require 'faker'

FactoryBot.define do
  factory :lounge do
    name  { Faker::Company.name }
    email { Faker::Internet.email }
    address_street_1 { Faker::Address.street_address }
    address_street_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    hours { "Mon-Fri 9am-5pm" }
    phone { Faker::PhoneNumber.cell_phone }
    zip_code { Faker::Address.zip_code }
    user
  end
end
