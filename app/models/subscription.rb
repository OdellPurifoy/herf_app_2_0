# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                   :bigint           not null, primary key
#  current_period_end   :datetime
#  current_period_start :datetime
#  interval             :string
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
class Subscription < ApplicationRecord
  belongs_to :user
end
