Given /I am logged in as a student director/ do
    @user_id = "student_director"
    puts 'TODO'
end

Given /I have created a schedule with the following times:/ do |schedule_table|
    table = schedule_table.rows
    sched_params = Schedule.group_weekday(table)
    sched_params[:user_id] = @user_id
    @schedule = Schedule.create(sched_params)
end

When /I select the following times:/ do |schedule_table|
    table = schedule_table.rows
    # Toggle 
    puts 'TODO'
end

When /I submit the schedule:/ do
    # Press button
    puts 'TODO'
end

Then /^I should have the following schedule:$/ do |schedule_table|
    user_schedule = Schedule.where(user_id: @user_id).first
    sched_map = Schedule.db_elem_to_map(user_schedule)
    table = schedule_table.rows
    table_map = Schedule.group_weekday(table)
    expect(sched_map).to eq table_map
end