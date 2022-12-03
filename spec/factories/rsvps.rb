FactoryBot.define do
  factory :rsvp do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { "MyString" }
    email { "MyString" }
    user { nil }
    event { nil }
  end
end
