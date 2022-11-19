# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  end_time         :time
#  event_date       :date
#  event_type       :string           not null
#  event_url        :string
#  maximum_capacity :integer
#  members_only     :boolean          default(FALSE)
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
  TYPES = ['Live Music', 'Whiskey Tasting', 'Cigar Brand Event', 'Holiday', 'Sports', 'Virtual'].freeze

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :lounge

  has_rich_text :description
  has_one_attached :flyer

  validates_presence_of :end_time, :event_date, :event_type, :name, :start_time
  validates :event_url, url: true, if: proc { |event| event.event_type == 'Virtual' }
  validate :end_date_not_after_start_date, :end_time_not_earlier_than_start_time

  after_commit :notify_followers_and_members, on: :create, if: proc { |event| event.members_only == false }
  after_commit :notify_members, on: :create
  after_commit :update_followers_and_members, on: :update, if: proc { |event| event.members_only == false }
  after_commit :update_members, on: :update
  after_commit :cancel_event_followers_and_members, on: :destroy, if: proc { |event| event.members_only == false }
  after_commit :cancel_members, on: :destroy

  private

  def end_date_not_after_start_date
    return if event_date.blank?

    errors.add(:event_date, 'Event date cannot be in the past') if event_date < Date.today
  end

  def end_time_not_earlier_than_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, 'End time cannot be earlier than start time.') if end_time.before?(start_time)
  end

  def notify_followers_and_members
    notify_followers
    notify_members
  end

  def update_followers_and_members
    update_followers
    update_members
  end

  def cancel_event_followers_and_members
    cancel_followers
    cancel_members
  end

  def notify_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      NotifyFollowersMailer.with(favoritor: favoritor, event: self).notify_followers.deliver_later
    end
  end

  def notify_members
    return if lounge.memberships.empty?

    lounge.memberships.each do |membership|
    end
  end

  def update_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      UpdatedEventNotificationMailer.with(favoritor: favoritor, event: self).update_notify_followers.deliver_later
    end
  end

  def update_members
    return if lounge.memberships.empty?

    lounge.memberships.each do |membership|
      UpdatedEventNotificationMailer.with(membership: membership, event: self).update_notify_members.deliver_later
    end
  end

  def cancellation_update_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      CancelledEventNotificationMailer.with(favoritor: favoritor, event: self).cancel_notify_followers.deliver_later
    end
  end

  def cancellation_update_members
    return if lounge.memberships.empty?

    lounge.memberships.each do |membership|
    end
  end
end
