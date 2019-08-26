# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    name { 'Anders Karlsson' }

    factory :member_contractor do
      duration { 1.week }
      member_type { 1 }
    end

    factory :member_employee do
      role { 'Software Engineer' }
      member_type { 2 }
    end
  end
end
