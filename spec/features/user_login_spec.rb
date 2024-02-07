# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User login', type: :feature do
  let(:user) { User.create(email: 'user@example.com', username: 'username', password: 'password') }

  scenario 'user navigates to login page and successfully logs in', js: true do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
  end
end
