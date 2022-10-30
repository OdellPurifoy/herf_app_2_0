# == Schema Information
#
# Table name: special_offers
#
#  id                 :bigint           not null, primary key
#  description        :text
#  end_date           :date
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

  # describe '#end_date_not_in_the_past' do
  #   let!(:lounge) { FactoryBot.create(:lounge) }
  #   let(:special_offer) { FactoryBot.build(:special_offer, end_date: (Date.today - 1.day), start_date: (Date.today), description: "blh", special_offer_type: "Brand", lounge: lounge) }

  #   it 'should raise a validation error' do
  #     special_offer.save!
  #     expect(special_offer.errors[:end_date]).to include('End date cannot be in the past')
  #   end
  # end
end
