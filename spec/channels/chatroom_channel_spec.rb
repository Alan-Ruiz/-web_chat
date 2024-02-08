# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatroomChannel, type: :channel do
  let(:user) { create(:user) }
  let(:chatroom) { create(:chatroom) }

  before do
    stub_connection current_user: user
  end

  it 'successfully subscribes' do
    subscribe(id: chatroom.id, user_id: user.id)
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_for(chatroom)
  end

  it 'does not subscribe without chatroom id' do
    subscribe(user_id: user.id)
    expect(subscription).to_not be_confirmed
  end

  it 'does not subscribe without user id' do
    subscribe(id: chatroom.id)
    expect(subscription).to_not be_confirmed
  end

  describe '#speak' do
    before do
      subscribe(id: chatroom.id, user_id: user.id)
    end

    it 'broadcasts a message' do
      expect {
        perform :speak, message: 'Hello, world!'
      }.to have_broadcasted_to(chatroom).with(hash_including(type: 'message', message: a_string_including('Hello, world!')))
    end
  end
end
