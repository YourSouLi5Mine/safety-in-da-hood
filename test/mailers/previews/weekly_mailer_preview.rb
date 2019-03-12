# Preview all emails at http://localhost:3000/rails/mailers/weekly_mailer
class WeeklyMailerPreview < ActionMailer::Preview
  def weekly_preview
    WeeklyMailer.stats
  end
end
