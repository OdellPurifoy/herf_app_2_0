# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:username).of_type(:string) }
  end

  describe 'Model Associations' do
    it { should have_many(:events).through(:lounges) }
    it { should have_many(:lounges).dependent(:destroy) }
  end

  describe 'Following a lounge' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:lounge) { FactoryBot.create(:lounge) }

    before do
      user.favorite(lounge)
    end

    it 'Should have 1 favorited lounge' do
      expect(user.favorites.count).to eq 1
    end

    it 'Should have the correct lounge as its followed lounge' do
      expect(user.favorited?(lounge)).to eq true
    end

    context 'when a user unfollows a lounge' do
      before do
        user.unfavorite(lounge)
      end

      it 'Should have zero followed lounges' do
        expect(user.favorites.count).to eq 0
      end

      it 'Should not be following the original lounge' do
        expect(user.favorited?(lounge)).to eq false
      end
    end
  end
end
