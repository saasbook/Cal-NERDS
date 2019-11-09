Given /I am logged in as a student director/ do
    @user_id = "student_director"
    puts 'TODO'
end

Given /I have created a schedule with the following times:/ do |schedule_table|
    table = schedule_table.rows
    @schedule = Schedule.create(user_id => @user_id,
                Schedule.group_weekday(table))
end

When /I select the following times:/ do |table|
    puts 'TODO'
end

Then /I should have another schedule/ do
    puts 'TODO'
end

Then /it should have the correct times/ do
    puts 'TODO'
end

Then /it should have no times/ do
    puts 'TODO'
end

When /I update the schedule:/ do |table|
    puts 'TODO'
end

Then /^my schedule should have the following times:$/ do |table|
    user_schedule = Schedule.where(user_id => @user_id)
    puts 'TODO'
end
