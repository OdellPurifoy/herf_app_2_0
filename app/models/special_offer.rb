# frozen_string_literal: true

# == Schema Information
#
# Table name: special_offers
#
#  id          :bigint           not null, primary key
#  description :text
#  end_date    :date
#  start_date  :date
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lounge_id   :bigint           not null
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

  validates_presence_of :description, :type, :start_date, :end_date
  validates :description, length: { maximum: 500 }
  # validate :end_date_not_in_the_past

  private

  def end_date_not_in_the_past
    if end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
end
