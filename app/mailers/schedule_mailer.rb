class ScheduleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def schedule_email(params)
    @user = params[:user]
    @admin = User.get_admins
    mail(to: @admin.email, subject: 'Schedule filled out')
  end
end
