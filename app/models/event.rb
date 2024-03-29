# frozen_string_literal: true

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
class Event < ApplicationRecord
  TYPES = ['Live Music', 'Whiskey Tasting', 'Cigar Brand Event', 'Holiday', 'Sports', 'Virtual'].freeze

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :lounge
  has_many :rsvps, dependent: :destroy

  has_one_attached :flyer

  validates_presence_of :end_time, :event_date, :event_type, :name, :start_time
  validates :event_description, length: { maximum: 1000, too_long: '%<count>s characters is the maximum allowed.' }
  validates :event_url, url: true, if: proc { |event| event.event_type == 'Virtual' }
  validate :end_date_not_after_start_date, :end_time_not_earlier_than_start_time

  paginates_per 10

  def self.send_reminder_text
    events_within_24_hours = where(event_date: Date.today + 1.day)
    return if events_within_24_hours.empty?

    events_within_24_hours.each do |event|
      reminder_message = %(
        Reminder, the #{event.name} event hosted by #{event.lounge.name} is tomorrow.
        Here are the details:
        Event: #{event.name}
        Date: #{event.event_date.strftime('%b %e, %Y')}
        Start Time: #{event.start_time.strftime('%l:%M %P')}
        End Time: #{event.end_time.strftime('%l:%M %P')}
        Location: #{event.lounge.address_street_1}, #{event.lounge.city}, #{event.lounge.state}, #{event.lounge.zip_code}
        Phone: #{event.lounge.phone}
      )
      event.lounge.memberships.active.each do |membership|
        TwilioClient.new.send_text(membership&.phone_number, reminder_message, event)
      end
    end
  end

  def self.send_reminder_email
    events_within_24_hours = where(event_date: Date.today + 1.day)
    return if events_within_24_hours.empty?

    events_within_24_hours.each do |event|
      event.lounge.memberships.active.each do |membership|
        OneDayReminderMailer.with(membership: membership, event: event).remind_members
        puts 'Email sent'
      end
    end
  end

  private

  def notify_followers_and_or_members
    if members_only?
      notify_members
      new_event_text_for_members
    else
      notify_members
      new_event_text_for_members
      notify_followers
      new_event_text_for_followers
    end
  end

  def update_followers_and_or_members
    if members_only?
      update_members
      updated_event_text_for_members
    else
      update_members
      updated_event_text_for_members
      update_followers
      updated_event_text_for_followers
    end
  end

  def cancel_follower_and_or_members
    if members_only?
      cancellation_event_members
      cancelled_event_text_for_members
    else
      cancellation_event_members
      cancelled_event_text_for_members
      cancellation_event_followers
      cancelled_event_text_for_followers
    end
  end

  def end_date_not_after_start_date
    return if event_date.blank?

    errors.add(:event_date, 'Event date cannot be in the past') if event_date < Date.today
  end

  def end_time_not_earlier_than_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, 'End time cannot be earlier than start time.') if end_time.before?(start_time)
  end

  def notify_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      NotifyFollowersMailer.with(favoritor: favoritor, event: self).notify_followers.deliver_later
    end
  end

  def update_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      UpdatedEventNotificationMailer.with(favoritor: favoritor, event: self).update_notify_followers.deliver_later
    end
  end

  def cancellation_event_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      CancelledEventNotificationMailer.with(favoritor: favoritor, event: self).cancel_notify_followers.deliver_later
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

  def cancelled_event_text_for_followers
    return if lounge.favoritors.empty?

    text_all_favoritors(lounge.favoritors, cancelled_event_message)
  end

  def update_rsvps_text
    return if rsvps.nil?

    rsvps.each do |rsvp|
      next if rsvp.phone_number.blank?

      TwilioClient.new.send_text(rsvp.phone_number, rsvp_update_message)
    end
  end

  def cancel_rsvps_text
    return if rsvps.nil?

    rsvps.each do |rsvp|
      next if rsvp.phone_number.blank?

      TwilioClient.new.send_text(rsvp.phone_number, rsvp_cancellation_message)
    end
  end

  def text_all_favoritors(favoritors, message)
    favoritors_phone_numbers = favoritors.pluck(:phone_number).compact

    favoritors_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, message)
    end
  end

  def rsvp_update_message
    %(#{rsvp.user.first_name}, your RSVP has been updated for the
      #{name} event, hosted by #{lounge.name}!
      Here are the latest details:
      Event: #{name}
      Date: #{event_date.strftime('%b %e, %Y')}
      Start Time: #{start_time.strftime('%l:%M %P')}
      End Time: #{end_time.strftime('%l:%M %P')}
      Location: #{lounge.address_street_1}, #{event.lounge.city}, #{event.lounge.state}, #{event.lounge.zip_code}
      Phone: #{lounge.phone})
  end

  def rsvp_cancellation_message
    %(Hi #{rsvp.user.first_name}, the
      #{name} event, hosted by #{lounge.name} has been cancelled.
      Please contact #{lounge.name} at #{lounge.phone} for more information.)
  end
end
