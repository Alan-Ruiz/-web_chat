# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    user = build(:user, username: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid with a duplicate username' do
    create(:user, username: 'testuser')
    user = build(:user, username: 'testuser')
    expect(user).not_to be_valid
  end

  it 'is not valid with a duplicate email' do
    create(:user, email: 'test@example.com')
    user = build(:user, email: 'test@example.com')
    expect(user).not_to be_valid
  end

  it 'is not valid with an invalid email' do
    user = build(:user, email: 'invalid')
    expect(user).not_to be_valid
  end
end
