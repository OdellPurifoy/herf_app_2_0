# frozen_string_literal: true

require 'rails_helper'

describe SpecialOfferPolicy do
  subject { described_class }

  permissions :new?, :create? do
    let(:user_1) { FactoryBot.create(:user, subscriptions: []) }
    let(:user_2) { FactoryBot.create(:user, admin: true) }

    it 'denies access if the user is not subscribed' do
      expect(subject).not_to permit(user_1, SpecialOffer.new)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(user_2, SpecialOffer.new)
    end
  end

  permissions :update?, :edit?, :destroy? do
    user_3 = FactoryBot.create(:user)
    user_4 = FactoryBot.create(:user, admin: true)
    user_5 = FactoryBot.create(:user)
    special_offer = FactoryBot.create(:special_offer, lounge: FactoryBot.create(:lounge, user: user_3))

    it "denies access if special_offer doesn't belong to the user" do
      expect(subject).not_to permit(user_5, special_offer)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(user_4, special_offer)
    end

    it 'grants access if user is the owner of the special_offer' do
      expect(subject).to permit(user_3, special_offer)
    end
  end
end
