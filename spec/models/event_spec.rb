# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  end_time         :time
#  event_date       :date
#  event_type       :string           not null
#  event_url        :string
#  maximum_capacity :integer
#  name             :string           not null
#  rsvp_needed      :boolean          default(FALSE)
#  slug             :string
#  start_time       :time
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  lounge_id        :bigint           not null
#
# Indexes
#
#  index_events_on_lounge_id  (lounge_id)
#  index_events_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:end_time).of_type(:time) }
    it { should have_db_column(:event_date).of_type(:date) }
    it { should have_db_column(:event_type).of_type(:string) }
    it { should have_db_column(:maximum_capacity).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:rsvp_needed).of_type(:boolean) }
    it { should have_db_column(:start_time).of_type(:time) }
    it { should have_db_index([:lounge_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:lounge) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:event_date) }
    it { should validate_presence_of(:event_type) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
  end

  describe '#end_date_not_after_start_date' do
    let(:event) { FactoryBot.build(:event, event_date: (Date.today - 1.day)) }

    it 'should raise a validation error' do
      event.validate
      expect(event.errors[:event_date]).to include('Event date cannot be in the past')
    end
  end

  describe '#end_time_not_earlier_than_start_time' do
    let(:event) { FactoryBot.build(:event, end_time: (Time.now - 1.hour)) }

    it 'should raise a validation error' do
      event.validate
      expect(event.errors[:end_time]).to include('End time cannot be earlier than start time.')
    end
  end

  describe '#notify_followers' do
    let(:lounge) { FactoryBot.create(:lounge, events: [event]) }
    let(:event) { FactoryBot.build(:event) }

    before do
      allow(event).to receive(:notify_followers)   
    end

    it 'should call the Notification Mailer with lounge followers' do
      event.save!
      expect(event).to have_received(:notify_followers)
    end
  end

  describe '#update_followers' do
    let!(:lounge) { FactoryBot.create(:lounge, events: [event]) }
    let!(:event) { FactoryBot.create(:event) }
    let(:old_event_date) { (Date.today + 1.day) }
    let(:new_event_date) { (Date.today + 3.days) }

    before do
      allow(event).to receive(:update_followers)   
    end

    it 'should call the Update event notification mailer with lounge followers' do
      event.event_date = new_event_date
      event.save!
      expect(event).to have_received(:update_followers)
    end
  end

  describe '#cancellation_update_followers' do
    let!(:lounge) { FactoryBot.create(:lounge, events: [event]) }
    let!(:event) { FactoryBot.create(:event) }

    before do
      allow(event).to receive(:cancellation_update_followers)   
    end

    it 'should call the Update event notification mailer with lounge followers' do
      event.destroy!
      expect(event).to have_received(:cancellation_update_followers)
    end
  end
end
