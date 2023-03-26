# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  end_time          :time
#  event_date        :date
#  event_description :text
#  event_type        :string           not null
#  event_url         :string
#  maximum_capacity  :integer
#  members_only      :boolean          default(FALSE)
#  name              :string           not null
#  rsvp_needed       :boolean          default(FALSE)
#  slug              :string
#  start_time        :time
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  lounge_id         :bigint           not null
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
    it { should have_db_column(:event_description).of_type(:text) }
    it { should have_db_column(:event_type).of_type(:string) }
    it { should have_db_column(:event_url).of_type(:string) }
    it { should have_db_column(:maximum_capacity).of_type(:integer) }
    it { should have_db_column(:members_only).of_type(:boolean) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:rsvp_needed).of_type(:boolean) }
    it { should have_db_column(:start_time).of_type(:time) }
    it { should have_db_index([:lounge_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:lounge) }
    it { should have_many(:rsvps).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:event_date) }
    it { should validate_presence_of(:event_type) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
  end

  describe 'Conditional Validations' do
    let(:event) { FactoryBot.create(:event, event_type: 'Virtual', event_url: '') }

    it 'triggers a validation error' do
      expect { event }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Event url is not a valid URL')
    end

    context "when event_type is 'Virtual and event_url is provided" do
      let(:event_2) { FactoryBot.create(:event, event_type: 'Virtual') }

      it 'does not trigger a validation error' do
        expect { event_2 }.to_not raise_error
      end
    end

    context 'when the url is provided but it is invalid' do
      let(:event_3) { FactoryBot.create(:event, event_type: 'Virtual', event_url: 'test-event.com') }

      it 'trigger an invalid url error' do
        expect { event_3 }.to raise_error
      end
    end
  end

  describe '.send_reminder_text' do
    let!(:lounge) { FactoryBot.create(:lounge, events: [event_1, event_2]) }
    let!(:event_1) { FactoryBot.create(:event,  event_date: Date.today + 1.day) }
    let!(:event_2) { FactoryBot.create(:event,  event_date: Date.today + 2.days) }

    before do
      allow(Event).to receive(:send_reminder_text).and_return(event_1)
    end

    it 'returns the event occuring 1 days from now' do
      expect(Event.send_reminder_text).to eq(event_1)
    end
  end

  describe '#end_date_not_after_start_date' do
    let(:event) { FactoryBot.build(:event, event_date: (Date.today - 1.day)) }

    it 'should raise a validation error' do
      event.validate
      expect(event.errors[:event_date]).to include('Event date cannot be in the past')
    end
  end

  describe '#end_time_not_earlier_than_start_time' do
    let(:event) { FactoryBot.build(:event, end_time: (DateTime.now - 1.day), start_time: DateTime.now) }

    it 'should raise a validation error' do
      event.validate
      expect(event.errors[:end_time]).to include('End time cannot be earlier than start time.')
    end
  end

  describe 'followers and members new event notifications' do
    context 'when the event is created members_only is false' do
      let(:lounge) { FactoryBot.create(:lounge, events: [event]) }
      let(:event) { FactoryBot.build(:event, members_only: false) }

      before do
        allow(event).to receive(:notify_followers_and_or_members)
        allow(event).to receive(:update_followers_and_or_members)
        allow(event).to receive(:cancel_follower_and_or_members)
      end

      it 'should only call the notify_followers_and_or_members callback' do
        event.save!
        expect(event).to have_received(:notify_followers_and_or_members)
        expect(event).to_not have_received(:update_followers_and_or_members)
        expect(event).to_not have_received(:cancel_follower_and_or_members)
      end
    end

    context 'when the event is created and members_only is true' do
      let(:lounge) { FactoryBot.create(:lounge, events: [event]) }
      let(:event) { FactoryBot.build(:event, members_only: true) }

      before do
        allow(event).to receive(:notify_followers_and_or_members)
        allow(event).to receive(:update_followers_and_or_members)
        allow(event).to receive(:cancel_follower_and_or_members)
      end

      it 'should only call the notify_followers_and_or_members callback' do
        event.save!
        expect(event).to have_received(:notify_followers_and_or_members)
        expect(event).to_not have_received(:update_followers_and_or_members)
        expect(event).to_not have_received(:cancel_follower_and_or_members)
      end
    end
  end

  describe 'followers and members event update notifications' do
    context 'when the event is updated' do
      let!(:lounge) { FactoryBot.create(:lounge, events: [event]) }
      let!(:event) { FactoryBot.create(:event, members_only: false) }
      let(:old_event_date) { (Date.today + 1.day) }
      let(:new_event_date) { (Date.today + 3.days) }

      before do
        allow(event).to receive(:notify_followers_and_or_members)
        allow(event).to receive(:update_followers_and_or_members)
        allow(event).to receive(:cancel_follower_and_or_members)
      end

      it 'should only call the update_followers_and_or_members callback' do
        event.update!(event_date: new_event_date)
        expect(event).to have_received(:update_followers_and_or_members)
        expect(event).to_not have_received(:notify_followers_and_or_members)
        expect(event).to_not have_received(:cancel_follower_and_or_members)
      end
    end

    context 'when event is updated and members_only is true' do
      let!(:lounge) { FactoryBot.create(:lounge, events: [event]) }
      let!(:event) { FactoryBot.create(:event, members_only: true) }
      let(:old_event_date) { (Date.today + 1.day) }
      let(:new_event_date) { (Date.today + 3.days) }

      before do
        allow(event).to receive(:notify_followers_and_or_members)
        allow(event).to receive(:update_followers_and_or_members)
        allow(event).to receive(:cancel_follower_and_or_members)
      end

      it 'should only call the update_followers_and_or_members callback' do
        event.update!(event_date: new_event_date)
        expect(event).to have_received(:update_followers_and_or_members)
        expect(event).to_not have_received(:notify_followers_and_or_members)
        expect(event).to_not have_received(:cancel_follower_and_or_members)
      end
    end
  end

  describe 'Followers and members event cancellation notifications' do
    context 'when an event is cancelled/destroyed' do
      let!(:lounge) { FactoryBot.create(:lounge, events: [event]) }
      let!(:event) { FactoryBot.create(:event, members_only: false) }

      before do
        allow(event).to receive(:notify_followers_and_or_members)
        allow(event).to receive(:update_followers_and_or_members)
        allow(event).to receive(:cancel_follower_and_or_members)
      end

      it 'should only call the cancel_follower_and_or_members callback' do
        event.destroy!
        expect(event).to have_received(:cancel_follower_and_or_members)
        expect(event).to_not have_received(:notify_followers_and_or_members)
        expect(event).to_not have_received(:update_followers_and_or_members)
      end
    end

    context 'when and event is cancelled/destroyed and members_only is true' do
      let!(:lounge) { FactoryBot.create(:lounge, events: [event]) }
      let!(:event) { FactoryBot.create(:event, members_only: true) }

      before do
        allow(event).to receive(:notify_followers_and_or_members)
        allow(event).to receive(:update_followers_and_or_members)
        allow(event).to receive(:cancel_follower_and_or_members)
      end

      it 'should call the cancel_event_followers_and_members callback' do
        event.destroy!
        expect(event).to have_received(:cancel_follower_and_or_members)
        expect(event).to_not have_received(:notify_followers_and_or_members)
        expect(event).to_not have_received(:update_followers_and_or_members)
      end
    end
  end

  describe 'Tying an Event to an RSVP record' do
    let!(:event) { FactoryBot.create(:event) }
    let!(:user) { FactoryBot.create(:user) }

    it 'should successfully tie the event to the RSVP record' do
      rsvp = Rsvp.create!(
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        number_of_guests: 3,
        phone_number: '',
        event_id: event.id,
        user_id: user.id
      )

      expect(event.reload.rsvps.first).to eq rsvp
    end
  end

  describe 'Updating Event RSVPs' do
    let!(:event) { FactoryBot.create(:event, rsvps: [rsvp]) }
    let!(:rsvp) { FactoryBot.create(:rsvp) }

    before do
      allow(event).to receive(:update_rsvps_text)
    end

    it 'calls the update_rsvps_text callback' do
      event.update!(name: "Updated name")
      expect(event).to have_received(:update_rsvps_text)
    end
  end

  describe 'Cancelling Event RSVps' do
    let!(:event) { FactoryBot.create(:event, rsvps: [rsvp]) }
    let!(:rsvp) { FactoryBot.create(:rsvp) }

    before do
      allow(event).to receive(:cancel_rsvps_text)
    end

    it 'calls the cancel_rsvps_text callback' do
      event.destroy!
      expect(event).to have_received(:cancel_rsvps_text)
    end
  end
end
