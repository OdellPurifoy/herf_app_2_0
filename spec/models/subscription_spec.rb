# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                   :bigint           not null, primary key
#  current_period_end   :datetime
#  current_period_start :datetime
#  plan_interval        :string
#  status               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  customer_id          :string
#  plan_id              :string
#  subscription_id      :string
#  user_id              :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'Database columns' do
    it { should have_db_column(:current_period_start).of_type(:datetime) }
    it { should have_db_column(:current_period_end).of_type(:datetime) }
    it { should have_db_column(:customer_id).of_type(:string) }
    it { should have_db_column(:plan_id).of_type(:string) }
    it { should have_db_column(:plan_interval).of_type(:string) }
    it { should have_db_column(:status).of_type(:string) }
    it { should have_db_column(:subscription_id).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_index([:user_id]) }
  end
end
