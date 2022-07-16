# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lounge, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:address_street_1).of_type(:string) }
    it { should have_db_column(:address_street_2).of_type(:string) }
    it { should have_db_column(:city).of_type(:string) }
    it { should have_db_column(:closing_time).of_type(:time) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:opening_time).of_type(:time) }
    it { should have_db_column(:phone).of_type(:string) }
    it { should have_db_column(:state).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:zip_code).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_index([:user_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:address_street_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end
end
