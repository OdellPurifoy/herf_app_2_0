# == Schema Information
#
# Table name: special_offers
#
#  id                 :bigint           not null, primary key
#  description        :text
#  end_date           :date
#  members_only       :boolean          default(FALSE)
#  special_offer_type :string
#  start_date         :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lounge_id          :bigint           not null
#
# Indexes
#
#  index_special_offers_on_lounge_id  (lounge_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'faker'

FactoryBot.define do
  factory :special_offer do
    special_offer_type { "Buy One, Get One (BOGO)" }
    description { "Check out our new special offer!" }
    start_date { (Date.today + 1.day) }
    end_date { (Date.today + 5.days) }
    lounge
  end
end
