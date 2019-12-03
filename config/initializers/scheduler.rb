require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.cron '12 00 * * 5' do
  User.get_non_admins.each do |user|
    for i in 1..4 do
      if !user.schedule_exists? (Date.today - i)
        ReminderMailer.reminder_email(user)
        return
      end
    end
  end
end
