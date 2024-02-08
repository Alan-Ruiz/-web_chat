# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  # Assuming you have a User model and a Chatroom model
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:chatroom) { create(:chatroom) }
  let(:message) { create(:message, user: user, chatroom: chatroom) }

  it 'is valid with valid attributes' do
    expect(message).to be_valid
  end

  it 'is not valid without content' do
    message.content = nil
    expect(message).to_not be_valid
  end

  it 'is not valid without a user' do
    message.user = nil
    expect(message).to_not be_valid
  end

  it 'is not valid without a chatroom' do
    message.chatroom = nil
    expect(message).to_not be_valid
  end

  it 'belongs to a user' do
    assc = Message.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it 'belongs to a chatroom' do
    assc = Message.reflect_on_association(:chatroom)
    expect(assc.macro).to eq :belongs_to
  end

  it 'returns true if the user is the sender' do
    expect(message.sender?(user)).to be true
  end

  it 'returns false if the user is not the sender' do
    expect(message.sender?(another_user)).to be false
  end
end
