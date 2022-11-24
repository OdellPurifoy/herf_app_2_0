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
  after_commit :notify_members, :new_event_text_for_members, on: :create
  after_commit :update_followers_and_members, on: :update, if: proc { |event| event.members_only == false }
  after_commit :update_members, on: :update
  after_commit :cancel_event_followers_and_members, on: :destroy, if: proc { |event| event.members_only == false }
  after_commit :cancellation_event_members, on: :destroy

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
    new_event_text_for_followers
    new_event_text_for_members
  end

  def update_followers_and_members
    update_followers
    update_members
    updated_event_text_for_followers
    updated_event_text_for_members
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

  def new_event_text_for_followers
    return if lounge.favoritors.empty?

    text_all_favoritors(lounge.favoritors, new_event_message)
  end

  def updated_event_text_for_followers
    return if lounge.favoritors.empty?

    text_all_favoritors(lounge.favoritors, updated_event_message)
  end
  
  def text_all_favoritors(favoritors, message)
    favoritors_phone_numbers = favoritors.pluck(:phone_number).compact
  
    favoritors_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, message)
    end
  end

  def notify_members
    return if lounge.memberships.empty?

    lounge.memberships.each do |membership|
      NotifyFollowersMailer.with(membership: membership, event: self).notify_members.deliver_later
    end
  end

  def new_event_text_for_members
    return if lounge.memberships.empty?

    text_all_members(lounge.memberships, message)
  end

  def updated_event_text_for_members
    return if lounge.favoritors.empty?

    text_all_members(lounge.memberships, updated_event_message)
  end

  def text_all_members(memberships, message)
    members_phone_numbers = memberships.pluck(:phone_number).compact

    members_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, new_event_message)
    end
  end

  def new_event_message
    %Q(You have been invited to #{self.name}, 
      hosted by #{self.lounge.name}! 
      Here are the details: #{self.description})
  end

  def updated_event_message
    %Q(The #{self.name} event, hosted by #{self.lounge.name} has been updated.
      Here are the latest details:
      Event: #{self.name}
      Date: #{self.event_date}
      Start Time: #{self.start_time}
      End Time: #{self.end_time}
      Location: #{self.lounge.address_street_1}, #{self.lounge.city}, #{self.lounge.state}, #{self.lounge.zip_code}
      Phone: #{self.lounge.phone})
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

  def cancellation_event_members
    return if lounge.memberships.empty?

    lounge.memberships.each do |membership|
      CancelledEventNotificationMailer.with(membership: membership, event: self).cancel_notify_members.deliver_later
    end
  end
end
