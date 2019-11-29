class ReminderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def reminder_email(params)
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Reminder to fill out schedules')
  end
end
