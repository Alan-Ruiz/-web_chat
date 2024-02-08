# frozen_string_literal: true

class User < ApplicationRecord
  before_create :assign_random_color

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def message_stats
    {
      sent: sent_messages_last_week,
      received: received_messages_last_week,
      since_last_message: messages_since_last_sent_message
    }
  end

  private

  def sent_messages_last_week
    messages.where(created_at: 1.week.ago..Time.current).count
  end

  def received_messages_last_week
    Message.where(created_at: 1.week.ago..Time.current)
           .where.not(user: self).count
  end

  def assign_random_color
    self.color = "##{format('%06x', (rand * 0xFFFFFF))}"
  end

  def messages_since_last_sent_message
    Message.where(Message.arel_table[:created_at].gteq(messages.last&.created_at))
           .where.not(user: self).count
  end
end
