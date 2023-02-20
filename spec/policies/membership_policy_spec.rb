# frozen_string_literal: true

require 'rails_helper'

describe MembershipPolicy do
  subject { described_class }

  permissions :new?, :create? do
    let(:user_1) { FactoryBot.create(:user, subscriptions: []) }
    let(:user_2) { FactoryBot.create(:user, admin: true) }

    it 'denies access if the user is not subscribed' do
      expect(subject).not_to permit(user_1, Membership.new)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(user_2, Membership.new)
    end
  end

  permissions :update?, :edit?, :destroy? do
    user_3 = FactoryBot.create(:user)
    user_4 = FactoryBot.create(:user, admin: true)
    user_5 = FactoryBot.create(:user)
    membership = FactoryBot.create(:membership, lounge: FactoryBot.create(:lounge, user: user_3))

    it "denies access if membership doesn't belong to the user" do
      expect(subject).not_to permit(user_5, membership)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(user_4, membership)
    end

    it 'grants access if user is the owner of the membership' do
      expect(subject).to permit(user_3, membership)
    end
  end
end
