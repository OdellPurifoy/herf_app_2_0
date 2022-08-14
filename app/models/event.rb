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
#  start_time_display :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lounge_id          :bigint           not null
#
# Indexes
#
#  index_events_on_lounge_id  (lounge_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
class Event < ApplicationRecord
  belongs_to :lounge

  has_rich_text :description
  has_one_attached :flyer

  validates_presence_of :end_time_display, :event_date, :event_type, :name, :start_time_display
end
