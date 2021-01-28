require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.cron '00 12 * * 5' do
  User.get_non_admins.each do |user|
    if !user.schedule_exists?((Date.today + 1.week).monday)
      ReminderMailer.reminder_email(user).deliver
    end
  end
end
