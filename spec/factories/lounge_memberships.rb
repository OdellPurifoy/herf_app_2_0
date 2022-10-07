FactoryBot.define do
  factory :lounge_membership do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    phone_number { "MyString" }
    lounge { nil }
  end
end
