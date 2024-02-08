# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def message_stats
    sent_messages_last_week = self.messages.where('created_at >= ?', 1.week.ago).count
    received_messages_last_week = Message.where('created_at >= ?', 1.week.ago).where.not(user: self).count
    messages_since_last_sent_message = Message.where('created_at >= ?', self.messages.last&.created_at).where.not(user: self).count

    { sent: sent_messages_last_week, received: received_messages_last_week, since_last_message: messages_since_last_sent_message }
  end
end
