# == Schema Information
#
# Table name: memberships
#
#  id           :bigint           not null, primary key
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lounge_id    :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_memberships_on_lounge_id  (lounge_id)
#  index_memberships_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (lounge_id => lounges.id)
#
require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:phone_number).of_type(:string) }
    it { should have_db_index([:lounge_id]) }
  end

  describe 'Model Associations' do
    it { should belong_to(:lounge) }
    it { should belong_to(:user).optional }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'Uniqueness Validations' do
    let!(:lounge) { FactoryBot.create(:lounge) }
    let!(:membership_1) { FactoryBot.create(:membership, email: 'test@example.com', lounge_id: lounge.id) }

    it { should validate_uniqueness_of(:email).scoped_to(:lounge_id) }
  end
end
