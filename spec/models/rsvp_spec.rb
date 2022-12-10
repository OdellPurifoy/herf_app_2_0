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
  describe 'Database columns' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:phone_number).of_type(:string) }
    it { should have_db_column(:number_of_guests).of_type(:integer) }
    it { should have_db_index([:event_id]) }
    it { should have_db_index([:user_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }

    context 'Uniqueness' do
      subject { FactoryBot.create(:rsvp, email: 'text@example.com', phone_number: '') }

      it { should validate_uniqueness_of(:email) }
    end

    context 'Numericality' do
      it { should validate_numericality_of(:number_of_guests) }
    end
  end

  describe 'New RSVP mailer' do
    context 'When a new RSVP is created' do
      let(:rsvp) { FactoryBot.build(:rsvp) }

      before do
        allow(rsvp).to receive(:notify_user)
      end

      it 'should call the notify_user callback' do
        rsvp.save!
        expect(rsvp).to have_received(:notify_user)
      end
    end
  end

  describe 'New RSVP text notification' do
    context 'When a new RSVP is created' do
      let(:rsvp) { FactoryBot.build(:rsvp, phone_number: '9178687000') }

      before do
        allow(rsvp).to receive(:text_user)
      end

      it 'shoud call the text_user callback' do
        rsvp.save!
        expect(rsvp).to have_received(:text_user)
      end

      context 'When the RSVP has no phone_number' do
        let(:rsvp) { FactoryBot.build(:rsvp, phone_number: '') }

        it 'does not call the text_user callback' do
          rsvp.save!
          expect(rsvp).not_to have_received(:text_user)
        end
      end
    end
  end
end
