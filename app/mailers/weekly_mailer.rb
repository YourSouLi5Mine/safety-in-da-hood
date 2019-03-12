class WeeklyMailer < ApplicationMailer
  default from: "precichysim@gmail.com"

  def weekly
    @users = User.all
    attachments['weekly_report.pdf'] =
      WickedPdf.new.pdf_from_string(
        render_to_string(
          partial: "pdf/weekly_report.html.erb"
        )
      )
    mail(to: "precichysim@gmail.com", subject: 'Weekly App Report')
  end
end
