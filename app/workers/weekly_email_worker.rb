class WeeklyEmailWorker
  include Sidekiq::Worker

  def perform
    User.find_each do |user|
      UserMailer.weekly_message_stats(user).deliver_now
    end
  end
end