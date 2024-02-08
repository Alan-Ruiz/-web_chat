class UserMailer < ApplicationMailer
  default from: 'alanrlondon90@gmail.com'

  def weekly_message_stats(user)
    @user = user
    @stats = @user.message_stats
    mail(to: @user.email, subject: 'Your weekly message stats')
  end
end