# frozen_string_literal: true

require 'rails_helper'

describe EventPolicy do
  subject { described_class }

  permissions :new?, :create? do
    let(:user_1) { FactoryBot.create(:user, subscriptions: []) }
    let(:user_2) { FactoryBot.create(:user, admin: true) }

    it 'denies access if the user is not subscribed' do
      expect(subject).not_to permit(user_1, Event.new)
    end

    it 'grants access if the user is an admin' do
      expect(subject).to permit(user_2, Event.new)
    end
  end

  permissions :update?, :edit?, :destroy? do
    user_3 = FactoryBot.create(:user)
    user_4 = FactoryBot.create(:user, admin: true)
    user_5 = FactoryBot.create(:user)
    event = FactoryBot.create(:event, lounge: FactoryBot.create(:lounge, user: user_3))

    it "denies access if event doesn't belong to the user" do
      expect(subject).not_to permit(user_5, event)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(user_4, event)
    end

    it 'grants access if user is the owner of the event' do
      expect(subject).to permit(user_3, event)
    end
  end
end
