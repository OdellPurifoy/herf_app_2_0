# == Schema Information
#
# Table name: events
#
#  id                 :bigint           not null, primary key
#  end_time_display   :string
#  event_date         :date
#  event_type         :string           not null
#  maximum_capacity   :integer
#  name               :string           not null
#  rsvp_needed        :boolean          default(FALSE)
#  start_time_display :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lounge_id          :bigint           not null
#
# Indexes
#
#  index_events_on_lounge_id  (lounge_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end