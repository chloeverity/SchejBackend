# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end

  factory :user do
    email
    password { 'testpassword' }
    password_confirmation { 'testpassword' }
  end
end
