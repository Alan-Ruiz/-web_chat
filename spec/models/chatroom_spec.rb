# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  let(:chatroom) { create(:chatroom) }

  it 'is valid with valid attributes' do
    expect(chatroom).to be_valid
  end

  it 'is not valid without a name' do
    chatroom.name = nil
    expect(chatroom).to_not be_valid
  end

  it 'has many messages' do
    assc = Chatroom.reflect_on_association(:messages)
    expect(assc.macro).to eq :has_many
  end

  it 'has many users through messages' do
    assc = Chatroom.reflect_on_association(:users)
    expect(assc.macro).to eq :has_many
    expect(assc.options[:through]).to eq :messages
  end
end
