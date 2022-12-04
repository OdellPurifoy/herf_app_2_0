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
require 'rails_helper'

RSpec.describe Rsvp, type: :model do
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:first_name).of_type(:string) }
  it { should have_db_column(:last_name).of_type(:string) }
  it { should have_db_column(:phone_number).of_type(:string) }
  it { should have_db_column(:number_of_guests).of_type(:integer) }
  it { should have_db_index([:event_id]) }
  it { should have_db_index([:user_id]) }
end
