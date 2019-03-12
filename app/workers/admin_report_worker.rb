class AdminReportWorker
  include Sidekiq::Worker

  def perform(*args)
    WeeklyMailer.weekly.deliver
  end
end
