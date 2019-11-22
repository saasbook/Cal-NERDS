Given /^I select the following variable times:$/ do |times_table|
	click_button "Variable Hours"
	times_table.hashes.each do |time|
		box_id = "##{time[:day]}-#{time[:time]}"
    find(box_id).click
	end
end

# Then /^(\w+) should have the following variable schedule:$/ do |name, schedule_table|
# 	user = User.find(name: name)
	
# end
