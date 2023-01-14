# frozen_string_literal: true

# == Schema Information
#
# Table name: memberships
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lounge_id    :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_memberships_on_lounge_id  (lounge_id)
#  index_memberships_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
class Membership < ApplicationRecord
  belongs_to :lounge
  belongs_to :user, optional: true

  validates_presence_of :email, :first_name, :last_name
  validates :email, uniqueness: { scope: :lounge_id, message: 'has already been taken' }

  paginates_per 10

  def self.search(search)
    where('email = ?', search) if search
  end
end
