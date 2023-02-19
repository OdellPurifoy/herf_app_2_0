# frozen_string_literal: true

require 'rails_helper'

describe LoungePolicy do
  subject { described_class }

  permissions :new?, :create? do
    let(:user_1) { FactoryBot.create(:user, subscriptions: []) }
    let(:user_2) { FactoryBot.create(:user, admin: true) }
    
    it "denies access if the user is not subscribed" do
      expect(subject).not_to permit(user_1, Lounge.new)
    end

    it "grants access if the user is an admin" do
      expect(subject).to permit(user_2, Lounge.new)
    end
  end

  permissions :update?, :edit?, :destroy? do
    it "denies access if lounge doesn't belong to the user" do
      expect(subject).not_to permit(User.new(id: 1), Lounge.new(user_id: 2))
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(id: 1, admin: true), Lounge.new(user_id: 2))
    end

    it "grants access if user is the owner of the lounge" do
      expect(subject).to permit(User.new(id: 1), Lounge.new(user_id: 1))
    end
  end
end
