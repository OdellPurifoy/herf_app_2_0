# frozen_string_literal: true

# == Schema Information
#
# Table name: rsvps
#
#  id               :bigint           not null, primary key
#  email            :string
#  first_name       :string
#  last_name        :string
#  number_of_guests :integer
#  phone_number     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  event_id         :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_rsvps_on_email     (email) UNIQUE
#  index_rsvps_on_event_id  (event_id)
#  index_rsvps_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates_presence_of :first_name, :last_name, :email
  validates :email, uniqueness: true
  validates :number_of_guests, numericality: true

  after_commit :notify_user, on: :create
  after_commit :text_user, on: :create, if: proc { |rsvp| rsvp.phone_number.present? }
  before_save :covert_number_of_guests_to_int

  private

  def notify_user
    email_notification
  end

  def text_user
    return if phone_number.blank?
  
    TwilioClient.new.send_text(phone_number, rsvp_confirmation_message)
  end

  def email_notification
    NewRsvpMailer.with(rsvp: self).notify_user
  end

  def rsvp_confirmation_message
    %(#{user.first_name}, your RSVP has been received for the
      #{event.name} hosted by #{event.lounge.name}!
      Here are the details:
      Event: #{event.name}
      Date: #{event.event_date}
      Start Time: #{event.start_time}
      End Time: #{event.end_time}
      Location: #{event.lounge.address_street_1}, #{event.lounge.city}, #{event.lounge.state}, #{event.lounge.zip_code}
      Phone: #{event.lounge.phone})
  end

  def covert_number_of_guests_to_int
    self[:number_of_guests].to_i
  end
end
