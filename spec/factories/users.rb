# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'testuser' }
    email { 'test@example.com' }
    password { 'password' }
  end
end
