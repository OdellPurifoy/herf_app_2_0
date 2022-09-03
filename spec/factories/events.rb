# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  end_time         :time
#  event_date       :date
#  event_type       :string           not null
#  maximum_capacity :integer
#  name             :string           not null
#  rsvp_needed      :boolean          default(FALSE)
#  slug             :string
#  start_time       :time
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  lounge_id        :bigint           not null
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
FactoryBot.define do
  factory :event do
    name { "Whiskey Tasting 101" }
    event_type { "Whiskey" }
    start_time { Time.now }
    end_time { Time.now + 3.hours }
    maximum_capacity { 1 }
    rsvp_needed { false }
    event_date { (Date.today + 1.day) }
    lounge
  end
end
