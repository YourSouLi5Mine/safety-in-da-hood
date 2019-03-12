class AdminReportWorker
  include Sidekiq::Worker

  def perform
    WeeklyMailer.stats.deliver
  end
end
