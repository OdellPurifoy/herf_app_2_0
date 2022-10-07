class Membership < ApplicationRecord
  belongs_to :lounge
  belongs_to :user, optional: true

  validates_presence_of :email, :first_name, :last_name
  validates :email, uniqueness: { scope: :lounge_id, message: 'A Membership already exists with this email.' }
end
