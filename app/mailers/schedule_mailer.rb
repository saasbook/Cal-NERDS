class ScheduleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def schedule_email(user)
    @user = user
    admins = User.get_admins
    admins.each do |admin|
    	@admin = admin
	    mail(to: @admin.email, subject: 'Schedule filled out')
	  end
  end
end
