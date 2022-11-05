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

  after_create_commit :notify_followers_and_members, if: proc { |special_offer| !special_offer.members_only? }
  after_create_commit :notify_members_only

  private

  def notify_followers_and_members
    notify_followers
    notify_members
  end

  def notify_members_only
    notify_members
  end

  def notify_members
    lounge.memberships.each do |membership|
      NewSpecialOfferMailer.with(membership: membership, special_offer: self).notify_members.deliver_later
    end
  end

  def notify_followers
    lounge.favoritors.each do |favoritor|
      NewSpecialOfferMailer.with(favoritor: favoritor, special_offer: self).notify_followers.deliver_later
    end
  end
end
