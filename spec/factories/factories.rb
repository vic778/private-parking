FactoryBot.define do
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
