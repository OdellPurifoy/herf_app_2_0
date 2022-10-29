FactoryBot.define do
  factory :special_offer do
    type { "" }
    description { "MyText" }
    start_date { "2022-10-29" }
    end_date { "2022-10-29" }
    lounge { nil }
  end
end
