class AdminReportWorker
  include Sidekiq::Worker

  def perform
    WeeklyMailer.weekly.deliver
  end
end
