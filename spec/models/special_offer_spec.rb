# == Schema Information
#
# Table name: special_offers
#
#  id                 :bigint           not null, primary key
#  description        :text
#  end_date           :date
#  members_only       :boolean          default(FALSE)
#  special_offer_type :string
#  start_date         :date
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lounge_id          :bigint           not null
#
# Indexes
#
#  index_special_offers_on_lounge_id  (lounge_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'rails_helper'

RSpec.describe SpecialOffer, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:end_date).of_type(:date) }
    it { should have_db_column(:members_only).of_type(:boolean) }
    it { should have_db_column(:start_date).of_type(:date) }
    it { should have_db_column(:special_offer_type).of_type(:string) }
    it { should have_db_index([:lounge_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:lounge) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:special_offer_type) }
  end

  describe 'followers and members notifications' do
    context 'when the special offer is created' do
      let(:lounge) { FactoryBot.create(:lounge, special_offers: [special_offer]) }
      let(:special_offer) { FactoryBot.build(:special_offer, members_only: false) }
  
      before do
        allow(special_offer).to receive(:notify_followers_and_members)   
      end
  
      it 'should call the notify_follower_and_members callback' do
        special_offer.save!
        expect(special_offer).to have_received(:notify_followers_and_members)
      end
    end

    context 'when the special offer is updated' do
      let!(:lounge) { FactoryBot.create(:lounge, special_offers: [special_offer]) }
      let!(:special_offer) { FactoryBot.build(:special_offer, members_only: false) }

      before do
        allow(special_offer).to receive(:update_followers_and_members)   
      end

      it 'should call the update_followers_and_members callback' do
        special_offer.update!(end_date: (Date.today + 14.days))
        expect(special_offer).to have_received(:update_followers_and_members)
      end
    end

    context 'when the special offer is deleted' do
      let!(:lounge) { FactoryBot.create(:lounge, special_offers: [special_offer]) }
      let!(:special_offer) { FactoryBot.build(:special_offer, members_only: false) }

      before do
        allow(special_offer).to receive(:cancel_special_offer_followers_and_members)   
      end

      it 'should call the cancel_special_offer_followers_and_members callback' do
        special_offer.destroy!
        expect(special_offer).to have_received(:cancel_special_offer_followers_and_members)
      end
    end
  end

  describe 'members only notifications' do
    context 'when a members_only special_offer is created' do
      let(:lounge_2) { FactoryBot.create(:lounge, special_offers: [special_offer_2]) }
      let(:special_offer_2) { FactoryBot.build(:special_offer, members_only: true) }
  
      before do
        allow(special_offer_2).to receive(:notify_members_only)   
      end
  
      it 'should call the notify_members_only callback' do
        special_offer_2.save!
        expect(special_offer_2).to have_received(:notify_members_only)
      end
    end

    context 'when a members_only special_offer is updated' do
      let!(:lounge_2) { FactoryBot.create(:lounge, special_offers: [special_offer_2]) }
      let!(:special_offer_2) { FactoryBot.build(:special_offer, members_only: true) }
  
      before do
        allow(special_offer_2).to receive(:update_members_only)   
      end
  
      it 'should call the update_members_only callback' do
        special_offer_2.update!(end_date: (Date.today + 14.days))
        expect(special_offer_2).to have_received(:update_members_only)
      end
    end

    context 'when a members only special offer is deleted' do
      let!(:lounge_2) { FactoryBot.create(:lounge, special_offers: [special_offer_2]) }
      let!(:special_offer_2) { FactoryBot.build(:special_offer, members_only: true) }
  
      before do
        allow(special_offer_2).to receive(:cancel_members_only)
        allow(special_offer_2).to receive(:cancel_special_offer_followers_and_members)   
      end
  
      it 'should call the update_members_only callback' do
        special_offer_2.destroy!
        expect(special_offer_2).to have_received(:cancel_members_only)
        expect(special_offer_2).to_not have_received(:cancel_special_offer_followers_and_members)
      end
    end
  end
end
