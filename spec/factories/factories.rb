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

    association :role, factory: :role

    trait :user do
      association :role, factory: :role, name: 'user'
    end

    trait :admin do
      association :role, factory: :role, name: 'admin'
    end
  end

  factory :parking do
    sequence :name do |n|
      "Parking #{n}"
    end
    address { "MyString" }
    open_time { "2023-01-25 10:17:56" }
    close_time { "2023-01-25 10:17:56" }
  end

  factory :slot_type do
    name { "car" }

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
    from { "2023-01-29 12:55:34" }
    to { "2023-02-25 12:55:34" }
    total_price { "10" }
    slot_type { "MyString" }
    number_of_hours { 1 }

    association :slot, factory: :slot
    association :customer, factory: :user
  end

  factory :booking do
    arrival_time { "2023-01-24 12:55:34" }
    left_time { "MyString" }
    total_price { "MyString" }
    ref_code { "MyString" }
    license_plate { "MyString" }
    status { "pneding" }

    association :slot, factory: :slot
  end
end
