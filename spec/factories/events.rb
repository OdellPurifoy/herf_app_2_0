# == Schema Information
#
# Table name: events
#
#  id                 :bigint           not null, primary key
#  end_time_display   :string
#  event_date         :date
#  event_type         :string           not null
#  maximum_capacity   :integer
#  name               :string           not null
#  rsvp_needed        :boolean          default(FALSE)
#  slug               :string
#  start_time_display :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lounge_id          :bigint           not null
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
    name { "MyString" }
    event_type { "MyString" }
    start_time_display { "MyString" }
    end_time_display { "MyString" }
    maximum_capacity { 1 }
    rsvp_needed { false }
    event_date { "2022-08-13" }
    lounge { nil }
  end
end
