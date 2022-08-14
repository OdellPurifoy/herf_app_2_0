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
  describe 'Database columns' do
    it { should have_db_column(:end_time_display).of_type(:string) }
    it { should have_db_column(:event_date).of_type(:date) }
    it { should have_db_column(:event_type).of_type(:string) }
    it { should have_db_column(:maximum_capacity).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:rsvp_needed).of_type(:boolean) }
    it { should have_db_column(:start_time_display).of_type(:string) }
    it { should have_db_index([:lounge_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:lounge) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:end_time_display) }
    it { should validate_presence_of(:event_date) }
    it { should validate_presence_of(:event_type) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time_display) }
  end
end
