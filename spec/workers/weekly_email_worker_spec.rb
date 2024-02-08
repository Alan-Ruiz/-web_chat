# frozen_string_literal: true

require 'rails_helper'
RSpec.describe WeeklyEmailWorker, type: :worker do
  describe '#perform' do
    it 'sends weekly emails to all users' do
      users = create_list(:user, 3) # assuming you have a User factory
      mail = double('Mail::Message')

      users.each do |user|
        expect(UserMailer).to receive(:weekly_message_stats).with(user).and_return(mail)
        expect(mail).to receive(:deliver_now)
      end

      WeeklyEmailWorker.new.perform
    end
  end
end
