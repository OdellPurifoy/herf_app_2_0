# frozen_string_literal: true

# == Schema Information
#
# Table name: lounges
#
#  id                     :bigint           not null, primary key
#  address_street_1       :string
#  address_street_2       :string
#  city                   :string
#  email                  :string
#  featured               :boolean          default(FALSE)
#  name                   :string
#  outside_cigars_allowed :boolean          default(FALSE)
#  outside_drinks_allowed :boolean          default(FALSE)
#  phone                  :string
#  slug                   :string
#  state                  :string
#  time_zone              :string
#  weekday_closing_hour   :string
#  weekday_opening_hour   :string
#  weekend_closing_hour   :string
#  weekend_opening_hour   :string
#  zip_code               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_lounges_on_slug     (slug) UNIQUE
#  index_lounges_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Lounge, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:address_street_1).of_type(:string) }
    it { should have_db_column(:address_street_2).of_type(:string) }
    it { should have_db_column(:city).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:featured).of_type(:boolean) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:phone).of_type(:string) }
    it { should have_db_column(:outside_cigars_allowed).of_type(:boolean) }
    it { should have_db_column(:outside_drinks_allowed).of_type(:boolean) }
    it { should have_db_column(:slug).of_type(:string) }
    it { should have_db_column(:state).of_type(:string) }
    it { should have_db_column(:time_zone).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:weekday_opening_hour).of_type(:string) }
    it { should have_db_column(:weekday_closing_hour).of_type(:string) }
    it { should have_db_column(:weekend_opening_hour).of_type(:string) }
    it { should have_db_column(:weekend_closing_hour).of_type(:string) }
    it { should have_db_column(:zip_code).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_index([:user_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:user) }
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:memberships).dependent(:destroy) }
  end

  describe 'Validations' do
    let!(:lest_lounge) { FactoryBot.create(:lounge) }

    it { should validate_presence_of(:address_street_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  describe 'Email REGEX validation' do
    let(:lounge) { FactoryBot.create(:lounge, email: 'invalid_emailexample.com') }

    it "raises an Email invalid error" do
      expect{lounge}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email Email invalid")
    end

    context "when valid email is used" do
      let(:lounge) { FactoryBot.create(:lounge, email: 'valid_email@example.com') }

      it "does not raise an error" do
        expect{lounge}.to_not raise_error
      end
    end
  end

  describe 'Zip code validation' do
    let(:lounge) { FactoryBot.create(:lounge, zip_code: "3463fsgfsfgs") }

    it "is not a valid zip code" do
      expect{lounge}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Zip code should be 12345 or 12345-1234")
    end

    context "when valid 5 digit zip code is used" do
      let(:lounge) { FactoryBot.create(:lounge, zip_code: "11211") }

      it "does not raise an error" do
        expect{lounge}.to_not raise_error
      end
    end

    context "when valid 9 digit zip code is used" do
      let(:lounge) { FactoryBot.create(:lounge, zip_code: "12345-1234") }

      it "does not raise an error" do
        expect{lounge}.to_not raise_error
      end
    end
  end

  describe '.featured' do
    let!(:lounge_1) { FactoryBot.create(:lounge, featured: true) }
    let!(:lounge_2) { FactoryBot.create(:lounge, featured: true) }
    let!(:lounge_3) { FactoryBot.create(:lounge, featured: false) }
    let!(:lounge_4) { FactoryBot.create(:lounge, featured: false) }

    it 'only returns lounges with the featured attribute set to true' do
      expect(Lounge.featured.length).to eq 2
    end

    context 'when there are no featured lounges' do
      let!(:lounge_1) { FactoryBot.create(:lounge, featured: false) }
      let!(:lounge_2) { FactoryBot.create(:lounge, featured: false) }
      let!(:lounge_3) { FactoryBot.create(:lounge, featured: false) }
      let!(:lounge_4) { FactoryBot.create(:lounge, featured: false) }

      it 'returns an empty collection' do
        expect(Lounge.featured).to eq []
      end
    end
  end

  describe 'lounge gaining followers' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:lounge) { FactoryBot.create(:lounge) }

    before do
      user.favorite(lounge)
    end

    it 'should tie the correct user to the correct lounge as a follower' do
      expect(lounge.favoritors.count).to eq 1
    end

    it 'the follower should be equal to the correct user' do
      expect(lounge.favoritors.first).to eq user
    end
  end

  describe 'lounge losing followers' do
    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }
    let!(:lounge) { FactoryBot.create(:lounge) }

    before do
      user_1.favorite(lounge)
      user_2.favorite(lounge)
    end

    it 'should have a total of 2 followers' do
      expect(lounge.favoritors.count).to eq 2
    end

    context 'when a user unfavorites a lounge' do
      before do
        user_1.unfavorite(lounge)
      end

      it 'should tie the correct user to the correct lounge as a follower' do
        expect(lounge.favoritors.count).to eq 1
      end

      it 'the follower should be equal to the correct user' do
        expect(lounge.favoritors.first).to eq user_2
      end
    end
  end

  describe 'creating new membership' do
    let!(:lounge) { FactoryBot.create(:lounge) }
    let(:membership) do
      lounge.memberships.build(first_name: 'TestName', last_name: 'TestLastName', email: 'test@example.com',
                               phone_number: '888-888-8888')
    end

    it 'creates the membership and ties it to the lounge' do
      membership.save!

      expect(membership.lounge).to eq lounge
    end
  end
end
