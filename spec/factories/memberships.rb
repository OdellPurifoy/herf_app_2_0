# == Schema Information
#
# Table name: memberships
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lounge_id    :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_memberships_on_lounge_id  (lounge_id)
#  index_memberships_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'faker'

FactoryBot.define do
  factory :membership do
    active { true }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }
    lounge
  end
end
