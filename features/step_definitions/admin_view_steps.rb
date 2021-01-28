Then /^I should see the following times for (\w+):$/ do |name, table|
    user = User.where(name: name)[0]
    table.rows.each do |day, time|
        table_id = "#"+day+'-'+time+'-'+user.id.to_s
        not_selected = page.find(table_id)[:class].include?("not-selected")
        expect(not_selected).to be(false), table_id + " was not selected."
    end
end

When /^I switch the user to (\w+)$/ do |name|
	visit "/"
	if page.has_content? "Log Out"
		click_on "Log Out"
	end
	steps %{I am logged in as #{name}}
end