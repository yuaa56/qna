# Preview all emails at http://localhost:3000/rails/mailers/dayly_mailer
class DailyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/dayly_mailer/digest
  def digest
    DailyMailer.digest
  end

end

