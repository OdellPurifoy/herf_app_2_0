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
end
