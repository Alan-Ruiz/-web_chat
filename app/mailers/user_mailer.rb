# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def weekly_message_stats(user)
    @user = user
    @stats = @user.message_stats
    mail(to: @user.email, subject: I18n.t('user_mailer.weekly_message_stats.subject'))
  end
end
