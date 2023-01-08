# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  end_time          :time
#  event_date        :date
#  event_description :text
#  event_type        :string           not null
#  event_url         :string
#  maximum_capacity  :integer
#  members_only      :boolean          default(FALSE)
#  name              :string           not null
#  rsvp_needed       :boolean          default(FALSE)
#  slug              :string
#  start_time        :time
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  lounge_id         :bigint           not null
#
# Indexes
#
#  index_events_on_lounge_id  (lounge_id)
#  index_events_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'faker'

FactoryBot.define do
  factory :event do
    name { "Whiskey Tasting 101" }
    event_type { "Whiskey" }
    event_url { "http://www.example.com" }
    start_time { (Date.today + 1.day).to_time }
    end_time { (Date.today + 2.days).to_time }
    maximum_capacity { 1 }
    members_only { false }
    rsvp_needed { false }
    event_date { (Date.today + 1.day) }
    lounge
  end
end
