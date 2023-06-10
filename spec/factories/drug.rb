# frozen_string_literal: true

FactoryBot.define do
  factory :drug do
    name { Faker::Name.name }
    amount { Faker::Alphanumeric.rand_in_range(1, 30) }
    price { Faker::Alphanumeric.rand * 100 }
    company { Faker::Company.name }
    description { Faker::Alphanumeric.alpha }
    deadline { Faker::Time.forward }
  end
end
