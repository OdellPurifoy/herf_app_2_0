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
end
