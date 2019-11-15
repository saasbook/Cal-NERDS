Given /^I have created a schedule with the following times for (\w+):$/ do |name, schedule_table|
    sched_params = {
        "mon_times" => [],
        "tue_times" => [],
        "wed_times" => [],
        "thu_times" => [],
        "fri_times" => [],
    }
    schedule_table.hashes.each do |sched|
        sched_params["#{sched[:day]}_times"] << sched[:time]
    end
    # sched_params = Schedule.group_weekday(table)
    user = User.where(name: name)[0]
    sched_params[:user_id] = user.id
    @schedule = Schedule.create(sched_params)
end

Then /^(\w+) should have the following schedule:$/ do |name, schedule_table|
    user = User.where(name: name)[0]
    user_schedule = Schedule.where(user_id: user.id).first
    sched_map = Schedule.parse_times_strings(user_schedule)
    table = schedule_table.rows
    table_map = Schedule.group_weekday(table)
    expect(sched_map).to eq table_map
end

Given /^I am viewing the schedule page for (\w+)$/ do |name|
    user = User.where(name: name)[0]
    visit user_schedules_path user
end

Given /^I am creating a schedule for (\w+)$/ do |name|
    user = User.where(name: name)[0]
    visit "/users/#{user.id}/schedules/new"
end

Given /^I select the following times:$/ do |times_table|
    times_table.hashes.each do |time|
        box_id = "##{time[:day]}-#{time[:time]}"
        find(box_id).click
    end
end

When /^I update (\w+)'s schedule with the following:$/ do |name, schedule_table|
    user = User.where(name: name)[0]
    sched = user.schedules[0]
    visit "/users/#{user.id}/schedules/#{sched.id}/edit"
    schedule_table.hashes.each do |s|
        box_id = "##{s[:day]}-#{s[:time]}"
        find(box_id).click
    end
end
