class DaylyDigestWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  requerrence {daily(1)}
  
  def perform
    User.send_daily_digest
  end
end