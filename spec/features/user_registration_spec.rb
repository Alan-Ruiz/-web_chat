# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User registration', type: :feature do

  before do
    @chatroom = Chatroom.create(name: 'Test Chatroom')
  end
  
  scenario 'user navigates to sign up page and successfully signs up', js: true do
    visit new_user_registration_path

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Username', with: 'username'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
