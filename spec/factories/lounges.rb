# frozen_string_literal: true

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
