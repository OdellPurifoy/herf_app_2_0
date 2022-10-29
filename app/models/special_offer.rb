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
  belongs_to :lounge
end
