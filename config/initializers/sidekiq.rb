require 'sidekiq/cron'

Sidekiq::Cron::Job.create(
  name: 'Weekly Email - every 1 week', 
  cron: '0 0 * * 0',   # run at 12:00 am every Sunday
  class: 'WeeklyEmailWorker'
)