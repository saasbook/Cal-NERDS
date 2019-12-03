Given /^there are no schedules in the database$/ do
    Schedule.delete_all
    expect(Schedule.all.count).to eq(0)
end

Given /^I have created a schedule with the following times for (\w+):$/ do |name, schedule_table|
    sched_params = {
        "mon_times" => [],
        "tue_times" => [],
        "wed_times" => [],
        "thu_times" => [],
        "fri_times" => [],
        "mon_var_times" => [],
        "tue_var_times" => [],
        "wed_var_times" => [],
        "thu_var_times" => [],
        "fri_var_times" => [],
    }
    schedule_table.hashes.each do |sched|
        if sched[:var] == "true"
            sched_params["#{sched[:day]}_var_times"] << sched[:time]
        else
            sched_params["#{sched[:day]}_times"] << sched[:time]
        end
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
    on_fixed = true
    times_table.hashes.each do |time|
        if on_fixed && time[:var] == "true"
            find('#variable-btn').click
            on_fixed = false
        elsif !on_fixed && time[:var] != "true"
            find('#fixed-btn').click
            on_fixed = true
        end
        box_id = "##{time[:day]}-#{time[:time]}"
        find(box_id).click
    end
end

When /^I update (\w+)'s schedule with the following:$/ do |name, schedule_table|
    user = User.where(name: name)[0]
    sched = user.schedules[0]
    visit "/users/#{user.id}/schedules/#{sched.id}/edit"
    on_fixed = true
    schedule_table.hashes.each do |s|
        if on_fixed && s[:var] == "true"
            find('#variable-btn').click
            on_fixed = false
        elsif !on_fixed && s[:var] != "true"
            find('#fixed-btn').click
            on_fixed = true
        end
        box_id = "##{s[:day]}-#{s[:time]}"
        find(box_id).click
    end
end
