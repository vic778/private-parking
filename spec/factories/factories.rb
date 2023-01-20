FactoryBot.define do
  factory :role do
    name { Role.names.keys.sample }

    to_create do |instance|
      instance.id = Role.find_or_create_by(name: instance.name).id
      instance.reload
    end
  end

  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    name { "John Doe" }

    password { "password" }

    association :role, factory: :role, name: 'user'

    trait :admin do
      association :role, factory: :role, name: 'admin'
    end
  end

  factory :parking do
    name { "MyString" }
    address { "MyString" }
    open_time { "2023-01-20 10:17:56" }
    close_time { "MyString" }
  end

  factory :slot_type do
    name { "MyString" }

    association :parking, factory: :parking
  end

  factory :slot do
    name { "MyString" }
    price { "MyString" }
    open_time { "2023-01-20 11:26:48" }
    close_time { "2023-01-20 11:26:48" }
    status { 1 }

    association :slot_type, factory: :slot_type
  end

  factory :reservation do
    date_and_time { "2023-01-20 12:55:34" }
    totat_price { 1 }
    slot_type { "MyString" }
    slot { nil }
  end

  factory :booking do
    arrival_time { "MyString" }
    left_time { "MyString" }
    total_price { "MyString" }
    ref_code { "MyString" }
    license_plate { "MyString" }
    slot { nil }
  end
end
