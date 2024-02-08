# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { 'MyString' }
    chatroom { Chatroom.first || association(:chatroom) }
    user { User.first || association(:user) }
  end
end
