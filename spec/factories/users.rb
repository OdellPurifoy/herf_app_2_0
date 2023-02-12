# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  city                   :string
#  country                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  customer_id            :string

#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    city { Faker::Address.city } #=> "Imogeneborough"
    country { 'United States' }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    password { Faker::Internet.password }
    phone_number { '9008007000' }
    subscription_status { 'Active' }
    subscription_start_date { DateTime.now }
    subscription_end_date { DateTime.now + 30.days }
  end
end
