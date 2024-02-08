require 'rails_helper'
require 'nokogiri'

RSpec.describe UserMailer, type: :mailer do
  describe 'weekly_message_stats' do
    let(:user) { create(:user) } # replace with your factory
    let!(:message) { create(:message, user: user) } # replace with your factory
    let(:mail) { UserMailer.weekly_message_stats(user) }

    it 'queues the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Your weekly message stats')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['alanrlondon90@gmail.com'])
    end

    it 'renders the body' do
      html_body = Nokogiri::HTML(mail.body.encoded)
      expect(html_body.text).to match(/1 messages have been exchanged in the last week./)
    end
  end
end