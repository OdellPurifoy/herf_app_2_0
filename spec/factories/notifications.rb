FactoryBot.define do
  factory :notification do
    body { "MyText" }
    read { false }
    user { nil }
  end
end
