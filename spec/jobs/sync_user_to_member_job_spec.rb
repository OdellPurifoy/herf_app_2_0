# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SyncUserToMemberJob, type: :job do
  let!(:membership) { FactoryBot.create(:membership, email: 'test_membership@example.com') }
  let(:user) { FactoryBot.build(:user, email: 'test_membership@example.com') }

  it 'syncs the user to the correct membership' do
    user.save!
    described_class.perform_now(user)
    expect(user.reload.memberships.first).to eq membership
  end

  context "when the emails don't match" do
    let!(:membership) { FactoryBot.create(:membership, email: 'different_membership@example.com') }

    it 'does not sync the user to the membership' do
      user.save!
      described_class.perform_now(user)
      expect(user.reload.memberships.first).to_not eq membership
    end
  end

  context "when there are multiple memberships for a user" do
    let!(:membership_1) { FactoryBot.create(:membership, email: 'test2_membership@example.com') }
    let!(:membership_2) { FactoryBot.create(:membership, email: 'test2_membership@example.com') }
    let(:user_memberships) { [membership_1, membership_2] }

    let(:user) { FactoryBot.build(:user, email: 'test2_membership@example.com') }

    it 'syncs the user to the correct membership' do
      user.save!
      described_class.perform_now(user)
      expect(user.reload.memberships).to match_array user_memberships
    end
  end
end
