# frozen_string_literal: true

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
class SpecialOffer < ApplicationRecord
  SPECIAL_OFFER_TYPES = ['Buy One, Get One (BOGO)', 'Discount', 'Brand', 'Members Only', 'Holiday'].freeze

  belongs_to :lounge

  has_one_attached :flyer

  validates_presence_of :description, :special_offer_type, :start_date, :end_date
  validates :description, length: { maximum: 500 }

  after_commit :notify_followers_and_or_members, on: :create
  after_commit :update_followers_and_or_members, on: :update
  after_commit :cancel_follower_and_or_members, on: :destroy

  paginates_per 10

  def self.search(search)
    where('special_offer_type = ?', search.titleize) if search
  end

  private

  def notify_followers_and_or_members
    if members_only?
      notify_members
      new_special_offer_text_for_members
    else
      notify_followers
      new_special_offer_text_for_followers
    end
  end

  def update_followers_and_or_members
    if members_only?
      update_members
      updated_special_offer_text_for_members
    else
      update_followers
      update_special_offer_text_for_followers
    end
  end

  def cancel_follower_and_or_members
    if members_only?
      cancellation_special_offer_members
      cancelled_special_offer_text_for_members
    else
      cancellation_special_offer_followers
      cancelled_special_offer_text_for_followers
    end
  end

  def new_special_offer_text_for_members
    return if lounge.memberships.empty?

    text_all_members(lounge.memberships, new_special_offer_message_for_members)
  end

  def text_all_members(memberships, message)
    members_phone_numbers = memberships.where(active: true).pluck(:phone_number).compact

    members_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, message)
    end
  end

  def new_special_offer_text_for_followers
    return if lounge.favoritors.empty?

    text_all_favoritors(lounge.favoritors, new_special_offer_message_for_followers)
  end

  def text_all_favoritors(favoritors, message)
    favoritors_phone_numbers = favoritors.pluck(:phone_number).compact

    favoritors_phone_numbers.each do |phone_number|
      TwilioClient.new.send_text(phone_number, message)
    end
  end

  def updated_special_offer_text_for_members
    return if lounge.memberships.empty?

    text_all_members(lounge.memberships, updated_special_offer_message)
  end

  def update_special_offer_text_for_followers
    return if lounge.favoritors.empty?

    text_all_favoritors(lounge.favoritors, updated_special_offer_message)
  end

  def cancelled_special_offer_text_for_members
    return if lounge.memberships.empty?

    text_all_members(lounge.memberships, cancelled_special_offer_message)
  end

  def cancelled_special_offer_text_for_followers
    return if lounge.favoritors.empty?

    text_all_favoritors(lounge.favoritors, cancelled_special_offer_message)
  end

  def new_special_offer_message_for_members
    %(New Members Only #{special_offer_type} special offer from #{lounge.name}!
      Here are the details: #{description}
      Begins: #{start_date}
      Ends: #{end_date})
  end

  def new_special_offer_message_for_followers
    %(New #{special_offer_type} special offer from #{lounge.name}!
      Here are the details: #{description}
      Begins: #{start_date}
      Ends: #{end_date})
  end

  def updated_special_offer_message
    %(The #{special_offer_type} special offer from #{lounge.name} has been updated.
      Here are the latest details: #{description}
      Begins: #{start_date}
      Ends: #{end_date})
  end

  def cancelled_special_offer_message
    %(The #{special_offer_type} special offer, has been cancelled.
      Please contact #{lounge.name} at: #{lounge.phone} for additional information.
      Thank you.)
  end

  def notify_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      NewSpecialOfferMailer.with(favoritor: favoritor, special_offer: self).notify_followers.deliver_later
    end
  end

  def notify_members
    lounge.memberships.where(active: true).each do |membership|
      NewSpecialOfferMailer.with(membership: membership, special_offer: self).notify_members.deliver_later
    end
  end

  def update_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      UpdateSpecialOfferMailer.with(favoritor: favoritor, special_offer: self).notify_followers.deliver_later
    end
  end

  def update_members
    lounge.memberships.where(active: true).each do |membership|
      UpdateSpecialOfferMailer.with(membership: membership, special_offer: self).notify_members.deliver_later
    end
  end

  def cancellation_special_offer_followers
    return if lounge.favoritors.empty?

    lounge.favoritors.each do |favoritor|
      CancelledSpecialOfferMailer.with(favoritor: favoritor, special_offer: self).notify_followers.deliver_later
    end
  end

  def cancellation_special_offer_members
    lounge.memberships.where(active: true).each do |membership|
      CancelledSpecialOfferMailer.with(membership: membership, special_offer: self).notify_members.deliver_later
    end
  end
end
