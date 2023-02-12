# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    plan_id { 'MyString' }
    customer_id { 'MyString' }
    user { nil }
    status { 'MyString' }
    current_period_start { '2023-02-12 16:34:06' }
    current_period_end { '2023-02-12 16:34:06' }
  end
end
