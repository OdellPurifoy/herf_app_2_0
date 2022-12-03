# == Schema Information
#
# Table name: rsvps
#
#  id           :bigint           not null, primary key
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  event_id     :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
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
end
