# frozen_string_literal: true

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
class Event < ApplicationRecord
  TYPES = ['Live Music', 'Whiskey Tasting', 'Cigar Brand Event', 'Holiday', 'Sports'].freeze

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :lounge

  has_rich_text :description
  has_one_attached :flyer

  validates_presence_of :end_time, :event_date, :event_type, :name, :start_time
  validate :end_date_not_after_start_date, :end_time_not_earlier_than_start_time

  private

  def end_date_not_after_start_date
    return if event_date.blank?

    errors.add(:event_date, 'Event date cannot be in the past') if event_date < Date.today
  end

  def end_time_not_earlier_than_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, 'End time cannot be earlier than start time.') if end_time.before?(start_time)
  end

  # TODO: Make this validation work
  # def start_time_not_earlier_than_now
  #   return if end_time.blank? || start_time.blank?

  #   errors.add(:start_time, 'Start time cannot be in the past.') if start_time.localtime.before?(Time.current.localtime)
  # end
end
